from django.db import models
from django.contrib.auth.models import User, Group, Permission
from datetime import datetime, timedelta
import json
import random
from django.utils import timezone
import pytz
# Create your models here.
from apps.grades.models import GradingSystem

enrollment_methods = (
    ("default", "Enroll Request"),
    ("open", "Open Enrollment"),
    )


attempts = [(i, i) for i in range(1, 6)]
attempts.append((-1, 'Infinite'))



test_status = (
                ('inprogress', 'Inprogress'),
                ('completed', 'Completed'),
              )


def get_file_dir(instance, filename):
    if isinstance(instance, LessonFile):
        upload_dir = instance.lesson.name.replace(" ", "_")
    else:
        upload_dir = instance.name.replace(" ", "_")
    return os.sep.join((upload_dir, filename))


###############################################################################
class CourseManager(models.Manager):

    def create_trial_course(self, user):
        """Creates a trial course for testing questions"""
        trial_course = self.create(name="trial_course", enrollment="open",
                                   creator=user, is_trial=True)
        trial_course.enroll(False, user)
        return trial_course

    def get_hidden_courses(self, code):
        return self.filter(code=code, hidden=True)


#############################################################################
class Lesson(models.Model):
    # Lesson name
    name = models.CharField(max_length=255)

    # Markdown text of lesson content
    description = models.TextField()

    # Markdown text should be in html format
    html_data = models.TextField(null=True, blank=True)

    # Creator of the lesson
    creator = models.ForeignKey(User, on_delete=models.CASCADE)

    # Activate/Deactivate Lesson
    active = models.BooleanField(default=True)

    # A video file
    video_file = models.FileField(
        upload_to=get_file_dir, default=None,
        null=True, blank=True,
        help_text="Please upload video files in mp4, ogv, webm format"
        )

    def __str__(self):
        return "{0}".format(self.name)

    def get_files(self):
        return LessonFile.objects.filter(lesson=self)

    def _create_lesson_copy(self, user):
        lesson_files = self.get_files()
        new_lesson = self
        new_lesson.id = None
        new_lesson.name = "Copy of {0}".format(self.name)
        new_lesson.creator = user
        new_lesson.save()
        for _file in lesson_files:
            file_name = os.path.basename(_file.file.name)
            if os.path.exists(_file.file.path):
                lesson_file = open(_file.file.path, "rb")
                django_file = File(lesson_file)
                lesson_file_obj = LessonFile()
                lesson_file_obj.lesson = new_lesson
                lesson_file_obj.file.save(file_name, django_file, save=True)
        return new_lesson

    def remove_file(self):
        if self.video_file:
            file_path = self.video_file.path
            if os.path.exists(file_path):
                os.remove(file_path)

    def _add_lesson_to_zip(self, next_unit, module, course, zip_file, path):
        lesson_name = self.name.replace(" ", "_")
        course_name = course.name.replace(" ", "_")
        module_name = module.name.replace(" ", "_")
        sub_folder_name = os.sep.join((
            course_name, module_name, lesson_name
            ))
        lesson_files = self.get_files()
        if self.video_file:
            video_file = os.sep.join((sub_folder_name, os.path.basename(
                        self.video_file.name)))
            zip_file.writestr(video_file, self.video_file.read())
        for lesson_file in lesson_files:
            if os.path.exists(lesson_file.file.path):
                filename = os.sep.join((sub_folder_name, os.path.basename(
                    lesson_file.file.name)))
                zip_file.writestr(filename, lesson_file.file.read())
        unit_file_path = os.sep.join((
            path, "templates", "yaksh", "download_course_templates", "unit.html"
            ))
        lesson_data = {"course": course, "module": module,
                       "lesson": self, "next_unit": next_unit,
                       "lesson_files": lesson_files}
        write_templates_to_zip(zip_file, unit_file_path, lesson_data,
                               lesson_name, sub_folder_name)


#############################################################################
class LessonFile(models.Model):
    lesson = models.ForeignKey(Lesson, related_name="lesson", on_delete=models.CASCADE)
    file = models.FileField(upload_to=get_file_dir, default=None)

    def remove(self):
        if os.path.exists(self.file.path):
            os.remove(self.file.path)
            if os.listdir(os.path.dirname(self.file.path)) == []:
                os.rmdir(os.path.dirname(self.file.path))
        self.delete()


###############################################################################
class QuizManager(models.Manager):
    def get_active_quizzes(self):
        return self.filter(active=True, is_trial=False)

    def create_trial_quiz(self, user):
        """Creates a trial quiz for testing questions"""
        trial_quiz = self.create(
            duration=1000, description="trial_questions",
            is_trial=True, time_between_attempts=0, creator=user
            )
        return trial_quiz

    def create_trial_from_quiz(self, original_quiz_id, user, godmode,
                               course_id):
        """Creates a trial quiz from existing quiz"""
        trial_course_name = "Trial_course_for_course_{0}_{1}".format(
            course_id, "godmode" if godmode else "usermode")
        trial_quiz_name = "Trial_orig_id_{0}_{1}".format(
            original_quiz_id,
            "godmode" if godmode else "usermode"
        )
        # Get or create Trial Course for usermode/godmode
        trial_course = Course.objects.filter(name=trial_course_name)
        if trial_course.exists():
            trial_course = trial_course.get(name=trial_course_name)
        else:
            trial_course = Course.objects.create(
                name=trial_course_name, creator=user, enrollment="open",
                is_trial=True)

        # Get or create Trial Quiz for usermode/godmode
        if self.filter(description=trial_quiz_name).exists():
            trial_quiz = self.get(description=trial_quiz_name)

        else:
            trial_quiz = self.get(id=original_quiz_id)
            trial_quiz.user = user
            trial_quiz.pk = None
            trial_quiz.description = trial_quiz_name
            trial_quiz.is_trial = True
            trial_quiz.prerequisite = None
            if godmode:
                trial_quiz.time_between_attempts = 0
                trial_quiz.duration = 1000
                trial_quiz.attempts_allowed = -1
                trial_quiz.active = True
                trial_quiz.start_date_time = timezone.now()
                trial_quiz.end_date_time = datetime(
                    2199, 1, 1, 0, 0, 0, 0, tzinfo=pytz.utc
                )
            trial_quiz.save()

        # Get or create Trial Ordered Lesson for usermode/godmode
        learning_modules = trial_course.get_learning_modules()
        if learning_modules:
            quiz = learning_modules[0].learning_unit.filter(quiz=trial_quiz)
            if not quiz.exists():
                trial_learning_unit = LearningUnit.objects.create(
                    order=1, quiz=trial_quiz, type="quiz",
                    check_prerequisite=False)
                learning_modules[0].learning_unit.add(trial_learning_unit.id)
            trial_learning_module = learning_modules[0]
        else:
            trial_learning_module = LearningModule.objects.create(
                name="Trial for {}".format(trial_course), order=1,
                check_prerequisite=False, creator=user, is_trial=True)
            trial_learning_unit = LearningUnit.objects.create(
                order=1, quiz=trial_quiz, type="quiz",
                check_prerequisite=False)
            trial_learning_module.learning_unit.add(trial_learning_unit.id)
            trial_course.learning_module.add(trial_learning_module.id)

        # Add user to trial_course
        trial_course.enroll(False, user)
        return trial_quiz, trial_course, trial_learning_module


###############################################################################
class Quiz(models.Model):
    """
    Một bài kiểm tra mà học sinh sẽ tham gia. Người ta có thể nghĩ về điều này
    như sự kiện "thi cử".
    """

    # Ngày bắt đầu và thời gian của bài kiểm tra.
    start_date_time = models.DateTimeField(
        "Ngày bắt đầu và thời gian của bài kiểm tra",
        default=timezone.now,
        null=True
    )

    # Ngày kết thúc và thời gian của bài kiểm tra
    end_date_time = models.DateTimeField(
        "Ngày kết thúc và thời gian của bài kiểm tra",
        default=datetime(
            2199, 1, 1,
            tzinfo=pytz.timezone(timezone.get_current_timezone_name())
        ),
        null=True
    )

    # Lam bai kiem tra trong x phut.
    duration = models.IntegerField("Thời lượng bài kiểm tra tính bằng phút", default=20)

    # Là bài kiểm tra hoạt động. Quản trị viên nên hủy kích hoạt bài kiểm tra một khi nó là
    # complete.
    active = models.BooleanField(default=True)

    # Description of quiz.
    description = models.CharField(max_length=256)

    # Điều kiện phần trăm vượt qua tối thiểu.
    pass_criteria = models.FloatField("Passing percentage", default=40)

    # Số lần thử cho bài kiểm tra
    attempts_allowed = models.IntegerField(default=1, choices=attempts)

    time_between_attempts = models.FloatField(
        "Time Between Quiz Attempts in hours", default=0.0
    )

    is_trial = models.BooleanField(default=False)

    instructions = models.TextField('Instructions for Students',
                                    default=None, blank=True, null=True)

    view_answerpaper = models.BooleanField('Allow student to view their answer\
                                            paper', default=False)

    allow_skip = models.BooleanField("Allow students to skip questions",
                                     default=True)

    weightage = models.FloatField(help_text='Will be considered as percentage',
                                  default=100)

    is_exercise = models.BooleanField(default=False)

    creator = models.ForeignKey(User, null=True, on_delete=models.CASCADE)

    objects = QuizManager()

    class Meta:
        verbose_name_plural = "Quizzes"

    def is_expired(self):
        return not self.start_date_time <= timezone.now() < self.end_date_time

    def create_demo_quiz(self, user):
        demo_quiz = Quiz.objects.create(
            start_date_time=timezone.now(),
            end_date_time=timezone.now() + timedelta(176590),
            duration=30, active=True,
            attempts_allowed=-1, time_between_attempts=0,
            description='Yaksh Demo quiz', pass_criteria=0,
            creator=user, instructions="<b>This is a demo quiz.</b>"
        )
        return demo_quiz

    def get_total_students(self, course):
        try:
            qp = self.questionpaper_set.get().id
        except QuestionPaper.DoesNotExist:
            qp = None
        return AnswerPaper.objects.filter(
                question_paper=qp,
                course=course
            ).values_list("user", flat=True).distinct().count()

    def get_passed_students(self, course):
        try:
            qp = self.questionpaper_set.get().id
        except QuestionPaper.DoesNotExist:
            qp = None
        return AnswerPaper.objects.filter(
                question_paper=qp,
                course=course, passed=True
            ).values_list("user", flat=True).distinct().count()

    def get_failed_students(self, course):
        try:
            qp = self.questionpaper_set.get().id
        except QuestionPaper.DoesNotExist:
            qp = None
        return AnswerPaper.objects.filter(
                question_paper=qp,
                course=course, passed=False
            ).values_list("user", flat=True).distinct().count()

    def get_answerpaper_status(self, user, course):
        try:
            qp = self.questionpaper_set.get().id
        except QuestionPaper.DoesNotExist:
            qp = None
        ans_ppr = AnswerPaper.objects.filter(
            user=user, course=course, question_paper=qp
        ).order_by("-attempt_number")
        if ans_ppr.exists():
            status = ans_ppr.first().status
        else:
            status = "not attempted"
        return status

    def get_answerpaper_passing_status(self, user, course):
        try:
            qp = self.questionpaper_set.get().id
        except QuestionPaper.DoesNotExist:
            qp = None
        ans_ppr = AnswerPaper.objects.filter(
            user=user, course=course, question_paper=qp
        ).order_by("-attempt_number")
        if ans_ppr.exists():
            return any([paper.passed for paper in ans_ppr])
        return False

    def _create_quiz_copy(self, user):
        question_papers = self.questionpaper_set.all()
        new_quiz = self
        new_quiz.id = None
        new_quiz.description = "Copy of {0}".format(self.description)
        new_quiz.creator = user
        new_quiz.save()
        for qp in question_papers:
            qp._create_duplicate_questionpaper(new_quiz)
        return new_quiz

    def __str__(self):
        desc = self.description or 'Quiz'
        return '%s: on %s for %d minutes' % (desc, self.start_date_time,
                                             self.duration)

    def _add_quiz_to_zip(self, next_unit, module, course, zip_file, path):
        quiz_name = self.description.replace(" ", "_")
        course_name = course.name.replace(" ", "_")
        module_name = module.name.replace(" ", "_")
        sub_folder_name = os.sep.join((
            course_name, module_name, quiz_name
            ))
        unit_file_path = os.sep.join((
            path, "templates", "yaksh", "download_course_templates", "quiz.html"
            ))
        quiz_data = {"course": course, "module": module,
                     "quiz": self, "next_unit": next_unit}

        write_templates_to_zip(zip_file, unit_file_path, quiz_data,
                               quiz_name, sub_folder_name)


##########################################################################
class LearningUnit(models.Model):
    """ Duy trì thứ tự bài học và bài kiểm tra được thêm vào trong khóa học """
    order = models.IntegerField()
    type = models.CharField(max_length=16)
    lesson = models.ForeignKey(Lesson, null=True, blank=True, on_delete=models.CASCADE)
    quiz = models.ForeignKey(Quiz, null=True, blank=True, on_delete=models.CASCADE)
    check_prerequisite = models.BooleanField(default=True)

    def get_lesson_or_quiz(self):
        return self.lesson if self.lesson else self.quiz

    def toggle_check_prerequisite(self):
        if self.check_prerequisite:
            self.check_prerequisite = False
        else:
            self.check_prerequisite = True

    def get_completion_status(self, user, course):
        course_status = CourseStatus.objects.filter(user=user, course=course)
        state = "not attempted"
        if course_status.exists():
            if self in course_status.first().completed_units.all():
                state = "completed"
            elif self.type == "quiz":
                state = self.quiz.get_answerpaper_status(user, course)
            elif course_status.first().current_unit == self:
                state = "inprogress"
        return state

    def has_prerequisite(self):
        return self.check_prerequisite

    def is_prerequisite_complete(self, user, learning_module, course):
        ordered_units = learning_module.learning_unit.order_by("order")
        ordered_units_ids = list(ordered_units.values_list("id", flat=True))
        current_unit_index = ordered_units_ids.index(self.id)
        if current_unit_index == 0:
            success = True
        else:
            prev_unit = ordered_units.get(
                id=ordered_units_ids[current_unit_index-1])
            status = prev_unit.get_completion_status(user, course)
            if status == "completed":
                success = True
            else:
                success = False
        return success

    def _create_unit_copy(self, user):
        if self.type == "quiz":
            new_quiz = self.quiz._create_quiz_copy(user)
            new_unit = LearningUnit.objects.create(
                order=self.order, type="quiz", quiz=new_quiz)
        else:
            new_lesson = self.lesson._create_lesson_copy(user)
            new_unit = LearningUnit.objects.create(
                order=self.order, type="lesson", lesson=new_lesson)
        return new_unit


###############################################################################
class LearningModule(models.Model):
    """ Learning Module to maintain learning units"""
    learning_unit = models.ManyToManyField(LearningUnit,
                                           related_name="learning_unit")
    name = models.CharField(max_length=255)
    description = models.TextField(default=None, null=True, blank=True)
    order = models.IntegerField(default=0)
    creator = models.ForeignKey(User, related_name="module_creator", on_delete=models.CASCADE)
    check_prerequisite = models.BooleanField(default=True)
    check_prerequisite_passes = models.BooleanField(default=False)
    html_data = models.TextField(null=True, blank=True)
    active = models.BooleanField(default=True)
    is_trial = models.BooleanField(default=False)

    def get_quiz_units(self):
        return [unit.quiz for unit in self.learning_unit.filter(
                type="quiz")]

    def get_lesson_units(self):
        return [unit.lesson for unit in self.learning_unit.filter(
                type="lesson").order_by("order")]

    def get_learning_units(self):
        return self.learning_unit.order_by("order")

    def get_added_quiz_lesson(self):
        learning_units = self.learning_unit.order_by("order")
        added_quiz_lessons = []
        if learning_units.exists():
            for unit in learning_units:
                if unit.type == "quiz":
                    added_quiz_lessons.append(("quiz", unit.quiz))
                else:
                    added_quiz_lessons.append(("lesson", unit.lesson))
        return added_quiz_lessons

    def toggle_check_prerequisite(self):
        self.check_prerequisite = not self.check_prerequisite

    def toggle_check_prerequisite_passes(self):
        self.check_prerequisite_passes = not self.check_prerequisite_passes

    def get_next_unit(self, current_unit_id):
        ordered_units = self.learning_unit.order_by("order")
        ordered_units_ids = list(ordered_units.values_list("id", flat=True))
        current_unit_index = ordered_units_ids.index(current_unit_id)
        next_index = current_unit_index + 1
        if next_index == len(ordered_units_ids):
            next_index = 0
        return ordered_units.get(id=ordered_units_ids[next_index])

    def get_status(self, user, course):
        """ Get module status if completed, inprogress or not attempted"""
        learning_module = course.learning_module.prefetch_related(
            "learning_unit").get(id=self.id)
        ordered_units = learning_module.learning_unit.order_by("order")
        status_list = [unit.get_completion_status(user, course)
                       for unit in ordered_units]

        if not status_list:
            default_status = "no units"
        elif all([status == "completed" for status in status_list]):
            default_status = "completed"
        elif all([status == "not attempted" for status in status_list]):
            default_status = "not attempted"
        else:
            default_status = "inprogress"
        return default_status

    def is_prerequisite_complete(self, user, course):
        """ Check if prerequisite module is completed """
        ordered_modules = course.learning_module.order_by("order")
        ordered_modules_ids = list(ordered_modules.values_list(
            "id", flat=True))
        current_module_index = ordered_modules_ids.index(self.id)
        if current_module_index == 0:
            success = True
        else:
            prev_module = ordered_modules.get(
                id=ordered_modules_ids[current_module_index-1])
            status = prev_module.get_status(user, course)
            if status == "completed":
                success = True
            else:
                success = False
        return success

    def get_passing_status(self, user, course):
        course_status = CourseStatus.objects.filter(user=user, course=course)
        if course_status.exists():
            learning_units_with_quiz = self.learning_unit.filter(type='quiz')
            ordered_units = learning_units_with_quiz.order_by("order")

        statuses = [
            unit.quiz.get_answerpaper_passing_status(user, course)
            for unit in ordered_units
        ]

        if not statuses:
            status = False
        else:
            status = all(statuses)
        return status

    def is_prerequisite_passed(self, user, course):
        """ Check if prerequisite module is passed """
        ordered_modules = course.learning_module.order_by("order")
        if ordered_modules.first() == self:
            return True
        else:
            if self.order == 0:
                return True
            prev_module = ordered_modules.get(order=self.order-1)
            status = prev_module.get_passing_status(user, course)
            return status

    def has_prerequisite(self):
        return self.check_prerequisite

    def get_module_complete_percent(self, course, user):
        units = self.get_learning_units()
        if not units:
            percent = 0.0
        else:
            status_list = [unit.get_completion_status(user, course)
                           for unit in units]
            count = status_list.count("completed")
            percent = round((count / units.count()) * 100)
        return percent

    def _create_module_copy(self, user, module_name):
        learning_units = self.learning_unit.order_by("order")
        new_module = self
        new_module.id = None
        new_module.name = module_name
        new_module.creator = user
        new_module.save()
        for unit in learning_units:
            new_unit = unit._create_unit_copy(user)
            new_module.learning_unit.add(new_unit)
        return new_module

    def _add_module_to_zip(self, course, zip_file, path):
        module_name = self.name.replace(" ", "_")
        course_name = course.name.replace(" ", "_")
        folder_name = os.sep.join((course_name, module_name))
        lessons = self.get_lesson_units()

        units = self.get_learning_units()
        for idx, unit in enumerate(units):
            next_unit = units[(idx + 1) % len(units)]
            if unit.type == 'lesson':
                unit.lesson._add_lesson_to_zip(next_unit,
                                               self,
                                               course,
                                               zip_file,
                                               path)
            else:
                unit.quiz._add_quiz_to_zip(next_unit,
                                           self,
                                           course,
                                           zip_file,
                                           path)

        module_file_path = os.sep.join((
            path, "templates", "yaksh", "download_course_templates", "module.html"
            ))
        module_data = {"course": course, "module": self, "units": units}
        write_templates_to_zip(zip_file, module_file_path, module_data,
                               module_name, folder_name)

    def __str__(self):
        return self.name


###############################################################################
class Course(models.Model):
    """ Course for students"""
    name = models.CharField(max_length=128) #ten
    enrollment = models.CharField(max_length=32, choices=enrollment_methods) #ghi danh
    active = models.BooleanField(default=True) #active
    code = models.CharField(max_length=128, null=True, blank=True) #code
    hidden = models.BooleanField(default=False) #an
    creator = models.ForeignKey(User, related_name='creator', on_delete=models.CASCADE)
    students = models.ManyToManyField(User, related_name='students')
    requests = models.ManyToManyField(User, related_name='requests')
    rejected = models.ManyToManyField(User, related_name='rejected')
    created_on = models.DateTimeField(auto_now_add=True)
    teachers = models.ManyToManyField(User, related_name='teachers')
    is_trial = models.BooleanField(default=False)
    instructions = models.TextField(default=None, null=True, blank=True)
    view_grade = models.BooleanField(default=False)
    learning_module = models.ManyToManyField(LearningModule,
                                             related_name='learning_module')

    # The start date of the course enrollment.
    start_enroll_time = models.DateTimeField(
        "Start Date and Time for enrollment of course",
        default=timezone.now,
        null=True
    )

    # The end date and time of the course enrollment
    end_enroll_time = models.DateTimeField(
        "End Date and Time for enrollment of course",
        default=datetime(
            2199, 1, 1,
            tzinfo=pytz.timezone(timezone.get_current_timezone_name())
        ),
        null=True
    )

    grading_system = models.ForeignKey(GradingSystem, null=True, blank=True, on_delete=models.CASCADE)

    objects = CourseManager()

    def _create_duplicate_instance(self, creator, course_name=None):
        new_course = self
        new_course.id = None
        new_course.name = course_name if course_name else self.name
        new_course.creator = creator
        new_course.save()
        return new_course

    def create_duplicate_course(self, user):
        learning_modules = self.learning_module.order_by("order")
        copy_course_name = "Copy Of {0}".format(self.name)
        new_course = self._create_duplicate_instance(user, copy_course_name)
        for module in learning_modules:
            copy_module_name = "Copy of {0}".format(module.name)
            new_module = module._create_module_copy(user, copy_module_name)
            new_course.learning_module.add(new_module)

    def request(self, *users):
        self.requests.add(*users)

    def get_requests(self):
        return self.requests.all()

    def is_active_enrollment(self):
        return self.start_enroll_time <= timezone.now() < self.end_enroll_time

    def enroll(self, was_rejected, *users):
        self.students.add(*users)
        if not was_rejected:
            self.requests.remove(*users)
        else:
            self.rejected.remove(*users)

    def get_enrolled(self):
        return self.students.all()

    def reject(self, was_enrolled, *users):
        self.rejected.add(*users)
        if not was_enrolled:
            self.requests.remove(*users)
        else:
            self.students.remove(*users)

    def get_rejected(self):
        return self.rejected.all()

    def is_enrolled(self, user):
        return user in self.students.all()

    def is_creator(self, user):
        return self.creator == user

    def is_teacher(self, user):
        return True if user in self.teachers.all() else False

    def is_self_enroll(self):
        return True if self.enrollment == enrollment_methods[1][0] else False

    def activate(self):
        self.active = True

    def deactivate(self):
        self.active = False

    def add_teachers(self, *teachers):
        self.teachers.add(*teachers)

    def get_teachers(self):
        return self.teachers.all()

    def remove_teachers(self, *teachers):
        self.teachers.remove(*teachers)

    def create_demo(self, user):
        course = Course.objects.filter(creator=user,
                                       name="Yaksh Demo course").exists()
        if not course:
            course = Course.objects.create(name="Yaksh Demo course",
                                           enrollment="open",
                                           creator=user)
            quiz = Quiz()
            demo_quiz = quiz.create_demo_quiz(user)
            demo_ques = Question()
            demo_ques.create_demo_questions(user)
            demo_que_ppr = QuestionPaper()
            demo_que_ppr.create_demo_quiz_ppr(demo_quiz, user)
            success = True
            file_path = os.sep.join(
                (os.path.dirname(__file__), "templates", "yaksh",
                 "demo_video.html")
                )
            rendered_text = render_template(file_path)
            lesson_data = "Demo Lesson\n{0}".format(rendered_text)
            demo_lesson = Lesson.objects.create(
                name="Demo Lesson", description=lesson_data,
                html_data=lesson_data, creator=user
                )
            quiz_unit = LearningUnit.objects.create(
                order=1, type="quiz", quiz=demo_quiz, check_prerequisite=False
                )
            lesson_unit = LearningUnit.objects.create(
                order=2, type="lesson", lesson=demo_lesson,
                check_prerequisite=False
                )
            learning_module = LearningModule.objects.create(
                name="Demo Module", description="<center>Demo Module</center>",
                creator=user, html_data="<center>Demo Module</center>",
                check_prerequisite=False
                )
            learning_module.learning_unit.add(quiz_unit)
            learning_module.learning_unit.add(lesson_unit)
            course.learning_module.add(learning_module)
        else:
            success = False
        return success

    def get_only_students(self):
        teachers = list(self.teachers.all().values_list("id", flat=True))
        teachers.append(self.creator.id)
        students = self.students.exclude(id__in=teachers)
        return students

    def get_learning_modules(self):
        return self.learning_module.order_by("order")

    def get_unit_completion_status(self, module, user, unit):
        course_module = self.learning_module.get(id=module.id)
        learning_unit = course_module.learning_unit.get(id=unit.id)
        return learning_unit.get_completion_status(user, self)

    def get_quizzes(self):
        learning_modules = self.learning_module.all()
        quiz_list = []
        for module in learning_modules:
            quiz_list.extend(module.get_quiz_units())
        return quiz_list

    def get_quiz_details(self):
        return [(quiz, quiz.get_total_students(self),
                 quiz.get_passed_students(self),
                 quiz.get_failed_students(self))
                for quiz in self.get_quizzes()]

    def get_learning_units(self):
        learning_modules = self.learning_module.all()
        learning_units = []
        for module in learning_modules:
            learning_units.extend(module.get_learning_units())
        return learning_units

    def remove_trial_modules(self):
        learning_modules = self.learning_module.all()
        for module in learning_modules:
            module.learning_unit.all().delete()
        learning_modules.delete()

    def is_last_unit(self, module, unit_id):
        last_unit = module.get_learning_units().last()
        return unit_id == last_unit.id

    def next_module(self, current_module_id):
        modules = self.get_learning_modules()
        module_ids = list(modules.values_list("id", flat=True))
        current_unit_index = module_ids.index(current_module_id)
        next_index = current_unit_index + 1
        if next_index == len(module_ids):
            next_index = 0
        return modules.get(id=module_ids[next_index])

    def percent_completed(self, user, modules):
        if not modules:
            percent = 0.0
        else:
            status_list = [module.get_module_complete_percent(self, user)
                           for module in modules]
            count = sum(status_list)
            percent = round((count / modules.count()))
        return percent

    def get_grade(self, user):
        course_status = CourseStatus.objects.filter(course=self, user=user)
        if course_status.exists():
            grade = course_status.first().get_grade()
        else:
            grade = "NA"
        return grade

    def get_current_unit(self, user):
        course_status = CourseStatus.objects.filter(course=self, user=user)
        if course_status.exists():
            return course_status.first().current_unit

    def days_before_start(self):
        """ Get the days remaining for the start of the course """
        if timezone.now() < self.start_enroll_time:
            remaining_days = (self.start_enroll_time - timezone.now()).days + 1
        else:
            remaining_days = 0
        return remaining_days

    def get_completion_percent(self, user):
        course_status = CourseStatus.objects.filter(course=self, user=user)
        if course_status.exists():
            percentage = course_status.first().percent_completed
        else:
            percentage = 0
        return percentage

    def is_student(self, user):
        return user in self.students.all()

    def create_zip(self, path, static_files):
        zip_file_name = string_io()
        with zipfile.ZipFile(zip_file_name, "a") as zip_file:
            course_name = self.name.replace(" ", "_")
            modules = self.get_learning_modules()
            file_path = os.sep.join(
                (
                    path, "templates", "yaksh",
                    "download_course_templates", "index.html"
                )
            )
            write_static_files_to_zip(zip_file, course_name, path,
                                      static_files)
            course_data = {"course": self, "modules": modules}
            write_templates_to_zip(zip_file, file_path, course_data,
                                   "index", course_name)
            for module in modules:
                module._add_module_to_zip(self, zip_file, path)
        return zip_file_name

    def has_lessons(self):
        modules = self.get_learning_modules()
        status = False
        for module in modules:
            if module.get_lesson_units():
                status = True
                break
        return status

    def __str__(self):
        return self.name

