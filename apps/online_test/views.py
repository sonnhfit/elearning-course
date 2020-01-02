from django.shortcuts import render, redirect
from .models import Course
# Create your views here.

def my_redirect(url):
    """An overridden redirect to deal with URL_ROOT-ing. See settings.py
    for details."""
    return redirect(URL_ROOT + url)


def index(request, next_url=None):
    """The start page.
    """
    user = request.user
    if user.is_authenticated():
        if is_moderator(user):
            return my_redirect('/exam/manage/' if not next_url else next_url)
        return my_redirect("/exam/quizzes/" if not next_url else next_url)

    return my_redirect("/exam/login/")


def prof_manage(request, msg=None):
    """Take credentials of the user with professor/moderator
    rights/permissions and log in."""
    user = request.user
    if not user.is_authenticated():
        return my_redirect('/exam/login')
    if not is_moderator(user):
        return my_redirect('/exam/')
    courses = Course.objects.filter(Q(creator=user) | Q(teachers=user),
                                    is_trial=False).distinct()
    trial_paper = AnswerPaper.objects.filter(
        user=user, question_paper__quiz__is_trial=True,
        course__is_trial=True
    )
    if request.method == "POST":
        delete_paper = request.POST.getlist('delete_paper')
        for answerpaper_id in delete_paper:
            answerpaper = AnswerPaper.objects.get(id=answerpaper_id)
            qpaper = answerpaper.question_paper
            answerpaper.course.remove_trial_modules()
            answerpaper.course.delete()
            if qpaper.quiz.is_trial:
                qpaper.quiz.delete()
            else:
                if qpaper.answerpaper_set.count() == 1:
                    qpaper.quiz.delete()
                else:
                    answerpaper.delete()

    context = {'user': user, 'courses': courses,
               'trial_paper': trial_paper, 'msg': msg
               }
    return my_render_to_response(
        request, 'yaksh/moderator_dashboard.html', context
    )


def quizlist_user(request, enrolled=None, msg=None):
    """Show All Quizzes that is available to logged-in user."""
    user = request.user
    courses_data = []

    if request.method == "POST":
        course_code = request.POST.get('course_code')
        hidden_courses = Course.objects.get_hidden_courses(code=course_code)
        courses = hidden_courses
        title = 'Search'

    elif enrolled is not None:
        courses = user.students.filter(is_trial=False).order_by('-id')
        title = 'Enrolled Courses'
    else:
        courses = Course.objects.filter(
            active=True, is_trial=False
        ).exclude(
           ~Q(requests=user), ~Q(rejected=user), hidden=True
        ).order_by('-id')
        title = 'All Courses'

    for course in courses:
        if user in course.students.all():
            _percent = course.get_completion_percent(user)
        else:
            _percent = None
        courses_data.append(
            {
                'data': course,
                'completion_percentage': _percent,
            }
        )

    context = {
        'user': user, 'courses': courses_data,
        'title': title, 'msg': msg
    }

    return my_render_to_response(request, "yaksh/quizzes_user.html", context)
