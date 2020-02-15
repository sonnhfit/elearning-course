--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases
--





--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5d56138d78cededb5d94790ccc6aeffe4';






--
-- Database creation
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.11 (Debian 10.11-1.pgdg90+1)
-- Dumped by pg_dump version 10.11 (Debian 10.11-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: confirm_email_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.confirm_email_token (
    token character varying(128) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.confirm_email_token OWNER TO postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: grades_graderange; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades_graderange (
    id integer NOT NULL,
    lower_limit double precision NOT NULL,
    upper_limit double precision NOT NULL,
    grade character varying(10) NOT NULL,
    description character varying(127),
    system_id integer NOT NULL
);


ALTER TABLE public.grades_graderange OWNER TO postgres;

--
-- Name: grades_graderange_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grades_graderange_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_graderange_id_seq OWNER TO postgres;

--
-- Name: grades_graderange_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grades_graderange_id_seq OWNED BY public.grades_graderange.id;


--
-- Name: grades_gradingsystem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades_gradingsystem (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    creator_id integer
);


ALTER TABLE public.grades_gradingsystem OWNER TO postgres;

--
-- Name: grades_gradingsystem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grades_gradingsystem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_gradingsystem_id_seq OWNER TO postgres;

--
-- Name: grades_gradingsystem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grades_gradingsystem_id_seq OWNED BY public.grades_gradingsystem.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    num_date integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.login_history OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_history_id_seq OWNER TO postgres;

--
-- Name: login_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_history_id_seq OWNED BY public.login_history.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: online_test_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answer (
    id integer NOT NULL,
    answer text,
    error text NOT NULL,
    marks double precision NOT NULL,
    correct boolean NOT NULL,
    skipped boolean NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_answer OWNER TO postgres;

--
-- Name: online_test_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answer_id_seq OWNER TO postgres;

--
-- Name: online_test_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answer_id_seq OWNED BY public.online_test_answer.id;


--
-- Name: online_test_answerpaper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answerpaper (
    id integer NOT NULL,
    attempt_number integer NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    user_ip character varying(15) NOT NULL,
    comments text NOT NULL,
    marks_obtained double precision,
    percent double precision,
    passed boolean,
    status character varying(20) NOT NULL,
    questions_order text NOT NULL,
    course_id integer,
    question_paper_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_answerpaper OWNER TO postgres;

--
-- Name: online_test_answerpaper_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answerpaper_answers (
    id integer NOT NULL,
    answerpaper_id integer NOT NULL,
    answer_id integer NOT NULL
);


ALTER TABLE public.online_test_answerpaper_answers OWNER TO postgres;

--
-- Name: online_test_answerpaper_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answerpaper_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answerpaper_answers_id_seq OWNER TO postgres;

--
-- Name: online_test_answerpaper_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answerpaper_answers_id_seq OWNED BY public.online_test_answerpaper_answers.id;


--
-- Name: online_test_answerpaper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answerpaper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answerpaper_id_seq OWNER TO postgres;

--
-- Name: online_test_answerpaper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answerpaper_id_seq OWNED BY public.online_test_answerpaper.id;


--
-- Name: online_test_answerpaper_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answerpaper_questions (
    id integer NOT NULL,
    answerpaper_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_answerpaper_questions OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_answered; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answerpaper_questions_answered (
    id integer NOT NULL,
    answerpaper_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_answerpaper_questions_answered OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_answered_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answerpaper_questions_answered_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answerpaper_questions_answered_id_seq OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_answered_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answerpaper_questions_answered_id_seq OWNED BY public.online_test_answerpaper_questions_answered.id;


--
-- Name: online_test_answerpaper_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answerpaper_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answerpaper_questions_id_seq OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answerpaper_questions_id_seq OWNED BY public.online_test_answerpaper_questions.id;


--
-- Name: online_test_answerpaper_questions_unanswered; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_answerpaper_questions_unanswered (
    id integer NOT NULL,
    answerpaper_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_answerpaper_questions_unanswered OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_unanswered_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_answerpaper_questions_unanswered_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_answerpaper_questions_unanswered_id_seq OWNER TO postgres;

--
-- Name: online_test_answerpaper_questions_unanswered_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_answerpaper_questions_unanswered_id_seq OWNED BY public.online_test_answerpaper_questions_unanswered.id;


--
-- Name: online_test_assignmentupload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_assignmentupload (
    id integer NOT NULL,
    "assignmentFile" character varying(100) NOT NULL,
    "assignmentQuestion_id" integer NOT NULL,
    course_id integer,
    question_paper_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_assignmentupload OWNER TO postgres;

--
-- Name: online_test_assignmentupload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_assignmentupload_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_assignmentupload_id_seq OWNER TO postgres;

--
-- Name: online_test_assignmentupload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_assignmentupload_id_seq OWNED BY public.online_test_assignmentupload.id;


--
-- Name: online_test_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    enrollment character varying(32) NOT NULL,
    active boolean NOT NULL,
    code character varying(128),
    hidden boolean NOT NULL,
    created_on timestamp with time zone NOT NULL,
    is_trial boolean NOT NULL,
    instructions text,
    view_grade boolean NOT NULL,
    start_enroll_time timestamp with time zone,
    end_enroll_time timestamp with time zone,
    creator_id integer NOT NULL,
    grading_system_id integer
);


ALTER TABLE public.online_test_course OWNER TO postgres;

--
-- Name: online_test_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_id_seq OWNER TO postgres;

--
-- Name: online_test_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_id_seq OWNED BY public.online_test_course.id;


--
-- Name: online_test_course_learning_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course_learning_module (
    id integer NOT NULL,
    course_id integer NOT NULL,
    learningmodule_id integer NOT NULL
);


ALTER TABLE public.online_test_course_learning_module OWNER TO postgres;

--
-- Name: online_test_course_learning_module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_learning_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_learning_module_id_seq OWNER TO postgres;

--
-- Name: online_test_course_learning_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_learning_module_id_seq OWNED BY public.online_test_course_learning_module.id;


--
-- Name: online_test_course_rejected; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course_rejected (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_course_rejected OWNER TO postgres;

--
-- Name: online_test_course_rejected_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_rejected_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_rejected_id_seq OWNER TO postgres;

--
-- Name: online_test_course_rejected_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_rejected_id_seq OWNED BY public.online_test_course_rejected.id;


--
-- Name: online_test_course_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course_requests (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_course_requests OWNER TO postgres;

--
-- Name: online_test_course_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_requests_id_seq OWNER TO postgres;

--
-- Name: online_test_course_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_requests_id_seq OWNED BY public.online_test_course_requests.id;


--
-- Name: online_test_course_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course_students (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_course_students OWNER TO postgres;

--
-- Name: online_test_course_students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_students_id_seq OWNER TO postgres;

--
-- Name: online_test_course_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_students_id_seq OWNED BY public.online_test_course_students.id;


--
-- Name: online_test_course_teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_course_teachers (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_course_teachers OWNER TO postgres;

--
-- Name: online_test_course_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_course_teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_course_teachers_id_seq OWNER TO postgres;

--
-- Name: online_test_course_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_course_teachers_id_seq OWNED BY public.online_test_course_teachers.id;


--
-- Name: online_test_fileupload; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_fileupload (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    "extract" boolean NOT NULL,
    hide boolean NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_fileupload OWNER TO postgres;

--
-- Name: online_test_fileupload_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_fileupload_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_fileupload_id_seq OWNER TO postgres;

--
-- Name: online_test_fileupload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_fileupload_id_seq OWNED BY public.online_test_fileupload.id;


--
-- Name: online_test_learningmodule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_learningmodule (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "order" integer NOT NULL,
    check_prerequisite boolean NOT NULL,
    check_prerequisite_passes boolean NOT NULL,
    html_data text,
    active boolean NOT NULL,
    is_trial boolean NOT NULL,
    creator_id integer NOT NULL
);


ALTER TABLE public.online_test_learningmodule OWNER TO postgres;

--
-- Name: online_test_learningmodule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_learningmodule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_learningmodule_id_seq OWNER TO postgres;

--
-- Name: online_test_learningmodule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_learningmodule_id_seq OWNED BY public.online_test_learningmodule.id;


--
-- Name: online_test_learningmodule_learning_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_learningmodule_learning_unit (
    id integer NOT NULL,
    learningmodule_id integer NOT NULL,
    learningunit_id integer NOT NULL
);


ALTER TABLE public.online_test_learningmodule_learning_unit OWNER TO postgres;

--
-- Name: online_test_learningmodule_learning_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_learningmodule_learning_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_learningmodule_learning_unit_id_seq OWNER TO postgres;

--
-- Name: online_test_learningmodule_learning_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_learningmodule_learning_unit_id_seq OWNED BY public.online_test_learningmodule_learning_unit.id;


--
-- Name: online_test_learningunit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_learningunit (
    id integer NOT NULL,
    "order" integer NOT NULL,
    type character varying(16) NOT NULL,
    check_prerequisite boolean NOT NULL,
    lesson_id integer,
    quiz_id integer
);


ALTER TABLE public.online_test_learningunit OWNER TO postgres;

--
-- Name: online_test_learningunit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_learningunit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_learningunit_id_seq OWNER TO postgres;

--
-- Name: online_test_learningunit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_learningunit_id_seq OWNED BY public.online_test_learningunit.id;


--
-- Name: online_test_lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_lesson (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    html_data text,
    active boolean NOT NULL,
    video_file character varying(100),
    creator_id integer NOT NULL
);


ALTER TABLE public.online_test_lesson OWNER TO postgres;

--
-- Name: online_test_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_lesson_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_lesson_id_seq OWNER TO postgres;

--
-- Name: online_test_lesson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_lesson_id_seq OWNED BY public.online_test_lesson.id;


--
-- Name: online_test_lessonfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_lessonfile (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    lesson_id integer NOT NULL
);


ALTER TABLE public.online_test_lessonfile OWNER TO postgres;

--
-- Name: online_test_lessonfile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_lessonfile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_lessonfile_id_seq OWNER TO postgres;

--
-- Name: online_test_lessonfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_lessonfile_id_seq OWNED BY public.online_test_lessonfile.id;


--
-- Name: online_test_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_profile (
    id integer NOT NULL,
    roll_number character varying(20) NOT NULL,
    institute character varying(128) NOT NULL,
    department character varying(64) NOT NULL,
    "position" character varying(64) NOT NULL,
    is_moderator boolean NOT NULL,
    timezone character varying(64) NOT NULL,
    is_email_verified boolean NOT NULL,
    activation_key character varying(255),
    key_expiry_time timestamp with time zone,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_profile OWNER TO postgres;

--
-- Name: online_test_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_profile_id_seq OWNER TO postgres;

--
-- Name: online_test_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_profile_id_seq OWNED BY public.online_test_profile.id;


--
-- Name: online_test_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_question (
    id integer NOT NULL,
    summary character varying(256) NOT NULL,
    description text NOT NULL,
    points double precision NOT NULL,
    language character varying(24) NOT NULL,
    type character varying(24) NOT NULL,
    active boolean NOT NULL,
    snippet text NOT NULL,
    partial_grading boolean NOT NULL,
    grade_assignment_upload boolean NOT NULL,
    min_time integer NOT NULL,
    solution text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.online_test_question OWNER TO postgres;

--
-- Name: online_test_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_question_id_seq OWNER TO postgres;

--
-- Name: online_test_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_question_id_seq OWNED BY public.online_test_question.id;


--
-- Name: online_test_questionpaper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_questionpaper (
    id integer NOT NULL,
    shuffle_questions boolean NOT NULL,
    total_marks double precision NOT NULL,
    fixed_question_order character varying(255) NOT NULL,
    shuffle_testcases boolean NOT NULL,
    quiz_id integer NOT NULL
);


ALTER TABLE public.online_test_questionpaper OWNER TO postgres;

--
-- Name: online_test_questionpaper_fixed_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_questionpaper_fixed_questions (
    id integer NOT NULL,
    questionpaper_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_questionpaper_fixed_questions OWNER TO postgres;

--
-- Name: online_test_questionpaper_fixed_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_questionpaper_fixed_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_questionpaper_fixed_questions_id_seq OWNER TO postgres;

--
-- Name: online_test_questionpaper_fixed_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_questionpaper_fixed_questions_id_seq OWNED BY public.online_test_questionpaper_fixed_questions.id;


--
-- Name: online_test_questionpaper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_questionpaper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_questionpaper_id_seq OWNER TO postgres;

--
-- Name: online_test_questionpaper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_questionpaper_id_seq OWNED BY public.online_test_questionpaper.id;


--
-- Name: online_test_questionpaper_random_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_questionpaper_random_questions (
    id integer NOT NULL,
    questionpaper_id integer NOT NULL,
    questionset_id integer NOT NULL
);


ALTER TABLE public.online_test_questionpaper_random_questions OWNER TO postgres;

--
-- Name: online_test_questionpaper_random_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_questionpaper_random_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_questionpaper_random_questions_id_seq OWNER TO postgres;

--
-- Name: online_test_questionpaper_random_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_questionpaper_random_questions_id_seq OWNED BY public.online_test_questionpaper_random_questions.id;


--
-- Name: online_test_questionset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_questionset (
    id integer NOT NULL,
    marks double precision NOT NULL,
    num_questions integer NOT NULL
);


ALTER TABLE public.online_test_questionset OWNER TO postgres;

--
-- Name: online_test_questionset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_questionset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_questionset_id_seq OWNER TO postgres;

--
-- Name: online_test_questionset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_questionset_id_seq OWNED BY public.online_test_questionset.id;


--
-- Name: online_test_questionset_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_questionset_questions (
    id integer NOT NULL,
    questionset_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.online_test_questionset_questions OWNER TO postgres;

--
-- Name: online_test_questionset_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_questionset_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_questionset_questions_id_seq OWNER TO postgres;

--
-- Name: online_test_questionset_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_questionset_questions_id_seq OWNED BY public.online_test_questionset_questions.id;


--
-- Name: online_test_quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.online_test_quiz (
    id integer NOT NULL,
    start_date_time timestamp with time zone,
    end_date_time timestamp with time zone,
    duration integer NOT NULL,
    active boolean NOT NULL,
    description character varying(256) NOT NULL,
    pass_criteria double precision NOT NULL,
    attempts_allowed integer NOT NULL,
    time_between_attempts double precision NOT NULL,
    is_trial boolean NOT NULL,
    instructions text,
    view_answerpaper boolean NOT NULL,
    allow_skip boolean NOT NULL,
    weightage double precision NOT NULL,
    is_exercise boolean NOT NULL,
    creator_id integer
);


ALTER TABLE public.online_test_quiz OWNER TO postgres;

--
-- Name: online_test_quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.online_test_quiz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.online_test_quiz_id_seq OWNER TO postgres;

--
-- Name: online_test_quiz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.online_test_quiz_id_seq OWNED BY public.online_test_quiz.id;


--
-- Name: reset_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reset_token (
    reset_token character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.reset_token OWNER TO postgres;

--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    key character varying(128) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: user_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_notification (
    id integer NOT NULL,
    is_read boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    notification_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.user_notification OWNER TO postgres;

--
-- Name: user_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_notification_id_seq OWNER TO postgres;

--
-- Name: user_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_notification_id_seq OWNED BY public.user_notification.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: grades_graderange id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_graderange ALTER COLUMN id SET DEFAULT nextval('public.grades_graderange_id_seq'::regclass);


--
-- Name: grades_gradingsystem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_gradingsystem ALTER COLUMN id SET DEFAULT nextval('public.grades_gradingsystem_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_history_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: online_test_answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answer ALTER COLUMN id SET DEFAULT nextval('public.online_test_answer_id_seq'::regclass);


--
-- Name: online_test_answerpaper id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper ALTER COLUMN id SET DEFAULT nextval('public.online_test_answerpaper_id_seq'::regclass);


--
-- Name: online_test_answerpaper_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_answers ALTER COLUMN id SET DEFAULT nextval('public.online_test_answerpaper_answers_id_seq'::regclass);


--
-- Name: online_test_answerpaper_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions ALTER COLUMN id SET DEFAULT nextval('public.online_test_answerpaper_questions_id_seq'::regclass);


--
-- Name: online_test_answerpaper_questions_answered id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_answered ALTER COLUMN id SET DEFAULT nextval('public.online_test_answerpaper_questions_answered_id_seq'::regclass);


--
-- Name: online_test_answerpaper_questions_unanswered id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_unanswered ALTER COLUMN id SET DEFAULT nextval('public.online_test_answerpaper_questions_unanswered_id_seq'::regclass);


--
-- Name: online_test_assignmentupload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload ALTER COLUMN id SET DEFAULT nextval('public.online_test_assignmentupload_id_seq'::regclass);


--
-- Name: online_test_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_id_seq'::regclass);


--
-- Name: online_test_course_learning_module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_learning_module ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_learning_module_id_seq'::regclass);


--
-- Name: online_test_course_rejected id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_rejected ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_rejected_id_seq'::regclass);


--
-- Name: online_test_course_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_requests ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_requests_id_seq'::regclass);


--
-- Name: online_test_course_students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_students ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_students_id_seq'::regclass);


--
-- Name: online_test_course_teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_teachers ALTER COLUMN id SET DEFAULT nextval('public.online_test_course_teachers_id_seq'::regclass);


--
-- Name: online_test_fileupload id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_fileupload ALTER COLUMN id SET DEFAULT nextval('public.online_test_fileupload_id_seq'::regclass);


--
-- Name: online_test_learningmodule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule ALTER COLUMN id SET DEFAULT nextval('public.online_test_learningmodule_id_seq'::regclass);


--
-- Name: online_test_learningmodule_learning_unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule_learning_unit ALTER COLUMN id SET DEFAULT nextval('public.online_test_learningmodule_learning_unit_id_seq'::regclass);


--
-- Name: online_test_learningunit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningunit ALTER COLUMN id SET DEFAULT nextval('public.online_test_learningunit_id_seq'::regclass);


--
-- Name: online_test_lesson id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lesson ALTER COLUMN id SET DEFAULT nextval('public.online_test_lesson_id_seq'::regclass);


--
-- Name: online_test_lessonfile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lessonfile ALTER COLUMN id SET DEFAULT nextval('public.online_test_lessonfile_id_seq'::regclass);


--
-- Name: online_test_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_profile ALTER COLUMN id SET DEFAULT nextval('public.online_test_profile_id_seq'::regclass);


--
-- Name: online_test_question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_question ALTER COLUMN id SET DEFAULT nextval('public.online_test_question_id_seq'::regclass);


--
-- Name: online_test_questionpaper id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper ALTER COLUMN id SET DEFAULT nextval('public.online_test_questionpaper_id_seq'::regclass);


--
-- Name: online_test_questionpaper_fixed_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_fixed_questions ALTER COLUMN id SET DEFAULT nextval('public.online_test_questionpaper_fixed_questions_id_seq'::regclass);


--
-- Name: online_test_questionpaper_random_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_random_questions ALTER COLUMN id SET DEFAULT nextval('public.online_test_questionpaper_random_questions_id_seq'::regclass);


--
-- Name: online_test_questionset id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset ALTER COLUMN id SET DEFAULT nextval('public.online_test_questionset_id_seq'::regclass);


--
-- Name: online_test_questionset_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset_questions ALTER COLUMN id SET DEFAULT nextval('public.online_test_questionset_questions_id_seq'::regclass);


--
-- Name: online_test_quiz id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_quiz ALTER COLUMN id SET DEFAULT nextval('public.online_test_quiz_id_seq'::regclass);


--
-- Name: user_notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_notification ALTER COLUMN id SET DEFAULT nextval('public.user_notification_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add notification	7	add_notification
26	Can change notification	7	change_notification
27	Can delete notification	7	delete_notification
28	Can view notification	7	view_notification
29	Can add user notification	8	add_usernotification
30	Can change user notification	8	change_usernotification
31	Can delete user notification	8	delete_usernotification
32	Can view user notification	8	view_usernotification
33	Can add token	9	add_token
34	Can change token	9	change_token
35	Can delete token	9	delete_token
36	Can view token	9	view_token
37	Can add reset token	10	add_resettoken
38	Can change reset token	10	change_resettoken
39	Can delete reset token	10	delete_resettoken
40	Can view reset token	10	view_resettoken
41	Can add login history	11	add_loginhistory
42	Can change login history	11	change_loginhistory
43	Can delete login history	11	delete_loginhistory
44	Can view login history	11	view_loginhistory
45	Can add confirm email token	12	add_confirmemailtoken
46	Can change confirm email token	12	change_confirmemailtoken
47	Can delete confirm email token	12	delete_confirmemailtoken
48	Can view confirm email token	12	view_confirmemailtoken
49	Can add grade range	13	add_graderange
50	Can change grade range	13	change_graderange
51	Can delete grade range	13	delete_graderange
52	Can view grade range	13	view_graderange
53	Can add grading system	14	add_gradingsystem
54	Can change grading system	14	change_gradingsystem
55	Can delete grading system	14	delete_gradingsystem
56	Can view grading system	14	view_gradingsystem
57	Can add answer	15	add_answer
58	Can change answer	15	change_answer
59	Can delete answer	15	delete_answer
60	Can view answer	15	view_answer
61	Can add question set	16	add_questionset
62	Can change question set	16	change_questionset
63	Can delete question set	16	delete_questionset
64	Can view question set	16	view_questionset
65	Can add learning unit	17	add_learningunit
66	Can change learning unit	17	change_learningunit
67	Can delete learning unit	17	delete_learningunit
68	Can view learning unit	17	view_learningunit
69	Can add lesson	18	add_lesson
70	Can change lesson	18	change_lesson
71	Can delete lesson	18	delete_lesson
72	Can view lesson	18	view_lesson
73	Can add question paper	19	add_questionpaper
74	Can change question paper	19	change_questionpaper
75	Can delete question paper	19	delete_questionpaper
76	Can view question paper	19	view_questionpaper
77	Can add assignment upload	20	add_assignmentupload
78	Can change assignment upload	20	change_assignmentupload
79	Can delete assignment upload	20	delete_assignmentupload
80	Can view assignment upload	20	view_assignmentupload
81	Can add course	21	add_course
82	Can change course	21	change_course
83	Can delete course	21	delete_course
84	Can view course	21	view_course
85	Can add learning module	22	add_learningmodule
86	Can change learning module	22	change_learningmodule
87	Can delete learning module	22	delete_learningmodule
88	Can view learning module	22	view_learningmodule
89	Can add quiz	23	add_quiz
90	Can change quiz	23	change_quiz
91	Can delete quiz	23	delete_quiz
92	Can view quiz	23	view_quiz
93	Can add file upload	24	add_fileupload
94	Can change file upload	24	change_fileupload
95	Can delete file upload	24	delete_fileupload
96	Can view file upload	24	view_fileupload
97	Can add answer paper	25	add_answerpaper
98	Can change answer paper	25	change_answerpaper
99	Can delete answer paper	25	delete_answerpaper
100	Can view answer paper	25	view_answerpaper
101	Can add profile	26	add_profile
102	Can change profile	26	change_profile
103	Can delete profile	26	delete_profile
104	Can view profile	26	view_profile
105	Can add question	27	add_question
106	Can change question	27	change_question
107	Can delete question	27	delete_question
108	Can view question	27	view_question
109	Can add lesson file	28	add_lessonfile
110	Can change lesson file	28	change_lessonfile
111	Can delete lesson file	28	delete_lessonfile
112	Can view lesson file	28	view_lessonfile
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$3K1ur5bxAda7$7vKWKCBrEM60avT7+b5IFo2sUhUlMjAq3KmecNr2NPk=	2020-01-07 04:01:47.174182+00	t	sonnhfit				t	t	2020-01-07 04:01:35.355541+00
2	pbkdf2_sha256$150000$DTWEeCPjkse6$M2/gqbHcgsf8LqkbGU2h3DM72pQzV5b20gJnDYV0G4I=	2020-02-15 12:16:34.799032+00	t	sonnh				t	t	2020-02-15 12:16:12.663869+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: confirm_email_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.confirm_email_token (token, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	users	notification
8	users	usernotification
9	users	token
10	users	resettoken
11	users	loginhistory
12	users	confirmemailtoken
13	grades	graderange
14	grades	gradingsystem
15	online_test	answer
16	online_test	questionset
17	online_test	learningunit
18	online_test	lesson
19	online_test	questionpaper
20	online_test	assignmentupload
21	online_test	course
22	online_test	learningmodule
23	online_test	quiz
24	online_test	fileupload
25	online_test	answerpaper
26	online_test	profile
27	online_test	question
28	online_test	lessonfile
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-01-07 03:46:16.77687+00
2	auth	0001_initial	2020-01-07 03:46:16.814905+00
3	admin	0001_initial	2020-01-07 03:46:16.862667+00
4	admin	0002_logentry_remove_auto_add	2020-01-07 03:46:16.877716+00
5	admin	0003_logentry_add_action_flag_choices	2020-01-07 03:46:16.887179+00
6	contenttypes	0002_remove_content_type_name	2020-01-07 03:46:16.908506+00
7	auth	0002_alter_permission_name_max_length	2020-01-07 03:46:16.9154+00
8	auth	0003_alter_user_email_max_length	2020-01-07 03:46:16.923956+00
9	auth	0004_alter_user_username_opts	2020-01-07 03:46:16.9348+00
10	auth	0005_alter_user_last_login_null	2020-01-07 03:46:16.944631+00
11	auth	0006_require_contenttypes_0002	2020-01-07 03:46:16.948176+00
12	auth	0007_alter_validators_add_error_messages	2020-01-07 03:46:16.958701+00
13	auth	0008_alter_user_username_max_length	2020-01-07 03:46:16.977161+00
14	auth	0009_alter_user_last_name_max_length	2020-01-07 03:46:16.991933+00
15	auth	0010_alter_group_name_max_length	2020-01-07 03:46:17.009701+00
16	auth	0011_update_proxy_permissions	2020-01-07 03:46:17.024159+00
17	grades	0001_initial	2020-01-07 03:46:17.069727+00
18	grades	default_grading_system	2020-01-07 03:46:17.093805+00
19	sessions	0001_initial	2020-01-07 03:46:17.105537+00
20	users	0001_initial	2020-01-07 03:46:17.210866+00
21	online_test	0001_initial	2020-01-07 04:07:48.027647+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
5a21u10vmpbt101fgqwe9kckqau0xfq1	ZjYyN2RjNDIxNTU1ODJiMmM0ODMxYTRkMWNlNTE0ZDU4YmNhM2QxZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYzhhYTc5ZWY2NWRhZmExMDU0MDk5ZWRhMDJkYWVmYTJmMzQ3NzkxIn0=	2020-01-21 04:01:47.177665+00
\.


--
-- Data for Name: grades_graderange; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades_graderange (id, lower_limit, upper_limit, grade, description, system_id) FROM stdin;
1	0	40	F	Fail	1
2	40	55	P	Pass	1
3	55	60	C	Average	1
4	60	75	B	Satisfactory	1
5	75	90	A	Good	1
6	90	101	A+	Excellent	1
\.


--
-- Data for Name: grades_gradingsystem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades_gradingsystem (id, name, description, creator_id) FROM stdin;
1	default	About the grading system!	\N
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (id, start_date, end_date, num_date, user_id) FROM stdin;
1	2020-02-15	2020-02-15	1	2
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, title, body, created_at) FROM stdin;
\.


--
-- Data for Name: online_test_answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answer (id, answer, error, marks, correct, skipped, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_answerpaper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answerpaper (id, attempt_number, start_time, end_time, user_ip, comments, marks_obtained, percent, passed, status, questions_order, course_id, question_paper_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_answerpaper_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answerpaper_answers (id, answerpaper_id, answer_id) FROM stdin;
\.


--
-- Data for Name: online_test_answerpaper_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answerpaper_questions (id, answerpaper_id, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_answerpaper_questions_answered; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answerpaper_questions_answered (id, answerpaper_id, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_answerpaper_questions_unanswered; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_answerpaper_questions_unanswered (id, answerpaper_id, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_assignmentupload; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_assignmentupload (id, "assignmentFile", "assignmentQuestion_id", course_id, question_paper_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course (id, name, enrollment, active, code, hidden, created_on, is_trial, instructions, view_grade, start_enroll_time, end_enroll_time, creator_id, grading_system_id) FROM stdin;
\.


--
-- Data for Name: online_test_course_learning_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course_learning_module (id, course_id, learningmodule_id) FROM stdin;
\.


--
-- Data for Name: online_test_course_rejected; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course_rejected (id, course_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_course_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course_requests (id, course_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_course_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course_students (id, course_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_course_teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_course_teachers (id, course_id, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_fileupload; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_fileupload (id, file, "extract", hide, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_learningmodule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_learningmodule (id, name, description, "order", check_prerequisite, check_prerequisite_passes, html_data, active, is_trial, creator_id) FROM stdin;
\.


--
-- Data for Name: online_test_learningmodule_learning_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_learningmodule_learning_unit (id, learningmodule_id, learningunit_id) FROM stdin;
\.


--
-- Data for Name: online_test_learningunit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_learningunit (id, "order", type, check_prerequisite, lesson_id, quiz_id) FROM stdin;
\.


--
-- Data for Name: online_test_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_lesson (id, name, description, html_data, active, video_file, creator_id) FROM stdin;
\.


--
-- Data for Name: online_test_lessonfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_lessonfile (id, file, lesson_id) FROM stdin;
\.


--
-- Data for Name: online_test_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_profile (id, roll_number, institute, department, "position", is_moderator, timezone, is_email_verified, activation_key, key_expiry_time, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_question (id, summary, description, points, language, type, active, snippet, partial_grading, grade_assignment_upload, min_time, solution, user_id) FROM stdin;
\.


--
-- Data for Name: online_test_questionpaper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_questionpaper (id, shuffle_questions, total_marks, fixed_question_order, shuffle_testcases, quiz_id) FROM stdin;
\.


--
-- Data for Name: online_test_questionpaper_fixed_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_questionpaper_fixed_questions (id, questionpaper_id, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_questionpaper_random_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_questionpaper_random_questions (id, questionpaper_id, questionset_id) FROM stdin;
\.


--
-- Data for Name: online_test_questionset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_questionset (id, marks, num_questions) FROM stdin;
\.


--
-- Data for Name: online_test_questionset_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_questionset_questions (id, questionset_id, question_id) FROM stdin;
\.


--
-- Data for Name: online_test_quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.online_test_quiz (id, start_date_time, end_date_time, duration, active, description, pass_criteria, attempts_allowed, time_between_attempts, is_trial, instructions, view_answerpaper, allow_skip, weightage, is_exercise, creator_id) FROM stdin;
\.


--
-- Data for Name: reset_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reset_token (reset_token, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (key, created, user_id) FROM stdin;
2:00953cad784e6c9d34c73c1e476a1f037827edabd3a07c74a5fe0acb85e34ee5	2020-02-15 12:19:19.566566+00	2
\.


--
-- Data for Name: user_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_notification (id, is_read, created_at, notification_id, user_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 28, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 21, true);


--
-- Name: grades_graderange_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_graderange_id_seq', 6, true);


--
-- Name: grades_gradingsystem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_gradingsystem_id_seq', 1, true);


--
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_history_id_seq', 1, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 1, false);


--
-- Name: online_test_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answer_id_seq', 1, false);


--
-- Name: online_test_answerpaper_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answerpaper_answers_id_seq', 1, false);


--
-- Name: online_test_answerpaper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answerpaper_id_seq', 1, false);


--
-- Name: online_test_answerpaper_questions_answered_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answerpaper_questions_answered_id_seq', 1, false);


--
-- Name: online_test_answerpaper_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answerpaper_questions_id_seq', 1, false);


--
-- Name: online_test_answerpaper_questions_unanswered_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_answerpaper_questions_unanswered_id_seq', 1, false);


--
-- Name: online_test_assignmentupload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_assignmentupload_id_seq', 1, false);


--
-- Name: online_test_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_id_seq', 1, false);


--
-- Name: online_test_course_learning_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_learning_module_id_seq', 1, false);


--
-- Name: online_test_course_rejected_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_rejected_id_seq', 1, false);


--
-- Name: online_test_course_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_requests_id_seq', 1, false);


--
-- Name: online_test_course_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_students_id_seq', 1, false);


--
-- Name: online_test_course_teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_course_teachers_id_seq', 1, false);


--
-- Name: online_test_fileupload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_fileupload_id_seq', 1, false);


--
-- Name: online_test_learningmodule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_learningmodule_id_seq', 1, false);


--
-- Name: online_test_learningmodule_learning_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_learningmodule_learning_unit_id_seq', 1, false);


--
-- Name: online_test_learningunit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_learningunit_id_seq', 1, false);


--
-- Name: online_test_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_lesson_id_seq', 1, false);


--
-- Name: online_test_lessonfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_lessonfile_id_seq', 1, false);


--
-- Name: online_test_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_profile_id_seq', 1, false);


--
-- Name: online_test_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_question_id_seq', 1, false);


--
-- Name: online_test_questionpaper_fixed_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_questionpaper_fixed_questions_id_seq', 1, false);


--
-- Name: online_test_questionpaper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_questionpaper_id_seq', 1, false);


--
-- Name: online_test_questionpaper_random_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_questionpaper_random_questions_id_seq', 1, false);


--
-- Name: online_test_questionset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_questionset_id_seq', 1, false);


--
-- Name: online_test_questionset_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_questionset_questions_id_seq', 1, false);


--
-- Name: online_test_quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.online_test_quiz_id_seq', 1, false);


--
-- Name: user_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_notification_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: confirm_email_token confirm_email_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirm_email_token
    ADD CONSTRAINT confirm_email_token_pkey PRIMARY KEY (token);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: grades_graderange grades_graderange_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_graderange
    ADD CONSTRAINT grades_graderange_pkey PRIMARY KEY (id);


--
-- Name: grades_gradingsystem grades_gradingsystem_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_gradingsystem
    ADD CONSTRAINT grades_gradingsystem_name_key UNIQUE (name);


--
-- Name: grades_gradingsystem grades_gradingsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_gradingsystem
    ADD CONSTRAINT grades_gradingsystem_pkey PRIMARY KEY (id);


--
-- Name: login_history login_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: online_test_answer online_test_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answer
    ADD CONSTRAINT online_test_answer_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper_answers online_test_answerpaper__answerpaper_id_answer_id_01ac306b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_answers
    ADD CONSTRAINT online_test_answerpaper__answerpaper_id_answer_id_01ac306b_uniq UNIQUE (answerpaper_id, answer_id);


--
-- Name: online_test_answerpaper_questions_answered online_test_answerpaper__answerpaper_id_question__320860ca_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_answered
    ADD CONSTRAINT online_test_answerpaper__answerpaper_id_question__320860ca_uniq UNIQUE (answerpaper_id, question_id);


--
-- Name: online_test_answerpaper_questions online_test_answerpaper__answerpaper_id_question__c23d2f25_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions
    ADD CONSTRAINT online_test_answerpaper__answerpaper_id_question__c23d2f25_uniq UNIQUE (answerpaper_id, question_id);


--
-- Name: online_test_answerpaper_questions_unanswered online_test_answerpaper__answerpaper_id_question__f472771d_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_unanswered
    ADD CONSTRAINT online_test_answerpaper__answerpaper_id_question__f472771d_uniq UNIQUE (answerpaper_id, question_id);


--
-- Name: online_test_answerpaper_answers online_test_answerpaper_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_answers
    ADD CONSTRAINT online_test_answerpaper_answers_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper online_test_answerpaper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper
    ADD CONSTRAINT online_test_answerpaper_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper_questions_answered online_test_answerpaper_questions_answered_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_answered
    ADD CONSTRAINT online_test_answerpaper_questions_answered_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper_questions online_test_answerpaper_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions
    ADD CONSTRAINT online_test_answerpaper_questions_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper_questions_unanswered online_test_answerpaper_questions_unanswered_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_unanswered
    ADD CONSTRAINT online_test_answerpaper_questions_unanswered_pkey PRIMARY KEY (id);


--
-- Name: online_test_answerpaper online_test_answerpaper_user_id_question_paper_i_bd85ca43_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper
    ADD CONSTRAINT online_test_answerpaper_user_id_question_paper_i_bd85ca43_uniq UNIQUE (user_id, question_paper_id, attempt_number, course_id);


--
-- Name: online_test_assignmentupload online_test_assignmentupload_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload
    ADD CONSTRAINT online_test_assignmentupload_pkey PRIMARY KEY (id);


--
-- Name: online_test_course_learning_module online_test_course_learn_course_id_learningmodule_fa47ff80_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_learning_module
    ADD CONSTRAINT online_test_course_learn_course_id_learningmodule_fa47ff80_uniq UNIQUE (course_id, learningmodule_id);


--
-- Name: online_test_course_learning_module online_test_course_learning_module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_learning_module
    ADD CONSTRAINT online_test_course_learning_module_pkey PRIMARY KEY (id);


--
-- Name: online_test_course online_test_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course
    ADD CONSTRAINT online_test_course_pkey PRIMARY KEY (id);


--
-- Name: online_test_course_rejected online_test_course_rejected_course_id_user_id_2608ec44_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_rejected
    ADD CONSTRAINT online_test_course_rejected_course_id_user_id_2608ec44_uniq UNIQUE (course_id, user_id);


--
-- Name: online_test_course_rejected online_test_course_rejected_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_rejected
    ADD CONSTRAINT online_test_course_rejected_pkey PRIMARY KEY (id);


--
-- Name: online_test_course_requests online_test_course_requests_course_id_user_id_bf3b739f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_requests
    ADD CONSTRAINT online_test_course_requests_course_id_user_id_bf3b739f_uniq UNIQUE (course_id, user_id);


--
-- Name: online_test_course_requests online_test_course_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_requests
    ADD CONSTRAINT online_test_course_requests_pkey PRIMARY KEY (id);


--
-- Name: online_test_course_students online_test_course_students_course_id_user_id_855449da_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_students
    ADD CONSTRAINT online_test_course_students_course_id_user_id_855449da_uniq UNIQUE (course_id, user_id);


--
-- Name: online_test_course_students online_test_course_students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_students
    ADD CONSTRAINT online_test_course_students_pkey PRIMARY KEY (id);


--
-- Name: online_test_course_teachers online_test_course_teachers_course_id_user_id_803d5ff1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_teachers
    ADD CONSTRAINT online_test_course_teachers_course_id_user_id_803d5ff1_uniq UNIQUE (course_id, user_id);


--
-- Name: online_test_course_teachers online_test_course_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_teachers
    ADD CONSTRAINT online_test_course_teachers_pkey PRIMARY KEY (id);


--
-- Name: online_test_fileupload online_test_fileupload_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_fileupload
    ADD CONSTRAINT online_test_fileupload_pkey PRIMARY KEY (id);


--
-- Name: online_test_learningmodule_learning_unit online_test_learningmodu_learningmodule_id_learni_36686158_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule_learning_unit
    ADD CONSTRAINT online_test_learningmodu_learningmodule_id_learni_36686158_uniq UNIQUE (learningmodule_id, learningunit_id);


--
-- Name: online_test_learningmodule_learning_unit online_test_learningmodule_learning_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule_learning_unit
    ADD CONSTRAINT online_test_learningmodule_learning_unit_pkey PRIMARY KEY (id);


--
-- Name: online_test_learningmodule online_test_learningmodule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule
    ADD CONSTRAINT online_test_learningmodule_pkey PRIMARY KEY (id);


--
-- Name: online_test_learningunit online_test_learningunit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningunit
    ADD CONSTRAINT online_test_learningunit_pkey PRIMARY KEY (id);


--
-- Name: online_test_lesson online_test_lesson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lesson
    ADD CONSTRAINT online_test_lesson_pkey PRIMARY KEY (id);


--
-- Name: online_test_lessonfile online_test_lessonfile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lessonfile
    ADD CONSTRAINT online_test_lessonfile_pkey PRIMARY KEY (id);


--
-- Name: online_test_profile online_test_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_profile
    ADD CONSTRAINT online_test_profile_pkey PRIMARY KEY (id);


--
-- Name: online_test_profile online_test_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_profile
    ADD CONSTRAINT online_test_profile_user_id_key UNIQUE (user_id);


--
-- Name: online_test_question online_test_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_question
    ADD CONSTRAINT online_test_question_pkey PRIMARY KEY (id);


--
-- Name: online_test_questionpaper_fixed_questions online_test_questionpape_questionpaper_id_questio_654c7cc2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_fixed_questions
    ADD CONSTRAINT online_test_questionpape_questionpaper_id_questio_654c7cc2_uniq UNIQUE (questionpaper_id, question_id);


--
-- Name: online_test_questionpaper_random_questions online_test_questionpape_questionpaper_id_questio_ddb76bbd_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_random_questions
    ADD CONSTRAINT online_test_questionpape_questionpaper_id_questio_ddb76bbd_uniq UNIQUE (questionpaper_id, questionset_id);


--
-- Name: online_test_questionpaper_fixed_questions online_test_questionpaper_fixed_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_fixed_questions
    ADD CONSTRAINT online_test_questionpaper_fixed_questions_pkey PRIMARY KEY (id);


--
-- Name: online_test_questionpaper online_test_questionpaper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper
    ADD CONSTRAINT online_test_questionpaper_pkey PRIMARY KEY (id);


--
-- Name: online_test_questionpaper_random_questions online_test_questionpaper_random_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_random_questions
    ADD CONSTRAINT online_test_questionpaper_random_questions_pkey PRIMARY KEY (id);


--
-- Name: online_test_questionset_questions online_test_questionset__questionset_id_question__ab43ba72_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset_questions
    ADD CONSTRAINT online_test_questionset__questionset_id_question__ab43ba72_uniq UNIQUE (questionset_id, question_id);


--
-- Name: online_test_questionset online_test_questionset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset
    ADD CONSTRAINT online_test_questionset_pkey PRIMARY KEY (id);


--
-- Name: online_test_questionset_questions online_test_questionset_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset_questions
    ADD CONSTRAINT online_test_questionset_questions_pkey PRIMARY KEY (id);


--
-- Name: online_test_quiz online_test_quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_quiz
    ADD CONSTRAINT online_test_quiz_pkey PRIMARY KEY (id);


--
-- Name: reset_token reset_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_token
    ADD CONSTRAINT reset_token_pkey PRIMARY KEY (reset_token);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (key);


--
-- Name: user_notification user_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_notification
    ADD CONSTRAINT user_notification_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: confirm_email_token_token_5b011d0e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX confirm_email_token_token_5b011d0e_like ON public.confirm_email_token USING btree (token varchar_pattern_ops);


--
-- Name: confirm_email_token_user_id_a738242a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX confirm_email_token_user_id_a738242a ON public.confirm_email_token USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: grades_graderange_system_id_775318a7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grades_graderange_system_id_775318a7 ON public.grades_graderange USING btree (system_id);


--
-- Name: grades_gradingsystem_creator_id_b4de4f90; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grades_gradingsystem_creator_id_b4de4f90 ON public.grades_gradingsystem USING btree (creator_id);


--
-- Name: grades_gradingsystem_name_e557ed32_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grades_gradingsystem_name_e557ed32_like ON public.grades_gradingsystem USING btree (name varchar_pattern_ops);


--
-- Name: login_history_user_id_0eeaebb8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX login_history_user_id_0eeaebb8 ON public.login_history USING btree (user_id);


--
-- Name: online_test_answer_question_id_927716e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answer_question_id_927716e9 ON public.online_test_answer USING btree (question_id);


--
-- Name: online_test_answerpaper_answers_answer_id_90cb56fb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_answers_answer_id_90cb56fb ON public.online_test_answerpaper_answers USING btree (answer_id);


--
-- Name: online_test_answerpaper_answers_answerpaper_id_4548dc22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_answers_answerpaper_id_4548dc22 ON public.online_test_answerpaper_answers USING btree (answerpaper_id);


--
-- Name: online_test_answerpaper_course_id_46f0e11a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_course_id_46f0e11a ON public.online_test_answerpaper USING btree (course_id);


--
-- Name: online_test_answerpaper_qu_answerpaper_id_723ec781; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_qu_answerpaper_id_723ec781 ON public.online_test_answerpaper_questions_answered USING btree (answerpaper_id);


--
-- Name: online_test_answerpaper_qu_answerpaper_id_ab6a4743; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_qu_answerpaper_id_ab6a4743 ON public.online_test_answerpaper_questions_unanswered USING btree (answerpaper_id);


--
-- Name: online_test_answerpaper_qu_question_id_1a1fb223; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_qu_question_id_1a1fb223 ON public.online_test_answerpaper_questions_unanswered USING btree (question_id);


--
-- Name: online_test_answerpaper_question_paper_id_9038de8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_question_paper_id_9038de8b ON public.online_test_answerpaper USING btree (question_paper_id);


--
-- Name: online_test_answerpaper_questions_answered_question_id_a23a9cde; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_questions_answered_question_id_a23a9cde ON public.online_test_answerpaper_questions_answered USING btree (question_id);


--
-- Name: online_test_answerpaper_questions_answerpaper_id_a344db1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_questions_answerpaper_id_a344db1b ON public.online_test_answerpaper_questions USING btree (answerpaper_id);


--
-- Name: online_test_answerpaper_questions_question_id_bd87f214; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_questions_question_id_bd87f214 ON public.online_test_answerpaper_questions USING btree (question_id);


--
-- Name: online_test_answerpaper_user_id_5eb27486; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_answerpaper_user_id_5eb27486 ON public.online_test_answerpaper USING btree (user_id);


--
-- Name: online_test_assignmentupload_assignmentQuestion_id_84c766bb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "online_test_assignmentupload_assignmentQuestion_id_84c766bb" ON public.online_test_assignmentupload USING btree ("assignmentQuestion_id");


--
-- Name: online_test_assignmentupload_course_id_42db3af1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_assignmentupload_course_id_42db3af1 ON public.online_test_assignmentupload USING btree (course_id);


--
-- Name: online_test_assignmentupload_question_paper_id_9c629ba3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_assignmentupload_question_paper_id_9c629ba3 ON public.online_test_assignmentupload USING btree (question_paper_id);


--
-- Name: online_test_assignmentupload_user_id_32c1e730; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_assignmentupload_user_id_32c1e730 ON public.online_test_assignmentupload USING btree (user_id);


--
-- Name: online_test_course_creator_id_2dd2f14e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_creator_id_2dd2f14e ON public.online_test_course USING btree (creator_id);


--
-- Name: online_test_course_grading_system_id_6c81f560; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_grading_system_id_6c81f560 ON public.online_test_course USING btree (grading_system_id);


--
-- Name: online_test_course_learning_module_course_id_0f5690ee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_learning_module_course_id_0f5690ee ON public.online_test_course_learning_module USING btree (course_id);


--
-- Name: online_test_course_learning_module_learningmodule_id_03e38929; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_learning_module_learningmodule_id_03e38929 ON public.online_test_course_learning_module USING btree (learningmodule_id);


--
-- Name: online_test_course_rejected_course_id_6d4fcc52; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_rejected_course_id_6d4fcc52 ON public.online_test_course_rejected USING btree (course_id);


--
-- Name: online_test_course_rejected_user_id_be12dedb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_rejected_user_id_be12dedb ON public.online_test_course_rejected USING btree (user_id);


--
-- Name: online_test_course_requests_course_id_5ab31b5e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_requests_course_id_5ab31b5e ON public.online_test_course_requests USING btree (course_id);


--
-- Name: online_test_course_requests_user_id_ff7444fb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_requests_user_id_ff7444fb ON public.online_test_course_requests USING btree (user_id);


--
-- Name: online_test_course_students_course_id_5f69e022; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_students_course_id_5f69e022 ON public.online_test_course_students USING btree (course_id);


--
-- Name: online_test_course_students_user_id_8760b79b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_students_user_id_8760b79b ON public.online_test_course_students USING btree (user_id);


--
-- Name: online_test_course_teachers_course_id_8a3e6f07; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_teachers_course_id_8a3e6f07 ON public.online_test_course_teachers USING btree (course_id);


--
-- Name: online_test_course_teachers_user_id_4aee6b7e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_course_teachers_user_id_4aee6b7e ON public.online_test_course_teachers USING btree (user_id);


--
-- Name: online_test_fileupload_question_id_ebfb4f24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_fileupload_question_id_ebfb4f24 ON public.online_test_fileupload USING btree (question_id);


--
-- Name: online_test_learningmodule_creator_id_5ca797b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_learningmodule_creator_id_5ca797b8 ON public.online_test_learningmodule USING btree (creator_id);


--
-- Name: online_test_learningmodule_learningmodule_id_89888508; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_learningmodule_learningmodule_id_89888508 ON public.online_test_learningmodule_learning_unit USING btree (learningmodule_id);


--
-- Name: online_test_learningmodule_learningunit_id_47e47326; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_learningmodule_learningunit_id_47e47326 ON public.online_test_learningmodule_learning_unit USING btree (learningunit_id);


--
-- Name: online_test_learningunit_lesson_id_8a508fe7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_learningunit_lesson_id_8a508fe7 ON public.online_test_learningunit USING btree (lesson_id);


--
-- Name: online_test_learningunit_quiz_id_c62703e9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_learningunit_quiz_id_c62703e9 ON public.online_test_learningunit USING btree (quiz_id);


--
-- Name: online_test_lesson_creator_id_44bb41d4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_lesson_creator_id_44bb41d4 ON public.online_test_lesson USING btree (creator_id);


--
-- Name: online_test_lessonfile_lesson_id_1553a7bb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_lessonfile_lesson_id_1553a7bb ON public.online_test_lessonfile USING btree (lesson_id);


--
-- Name: online_test_question_user_id_93779a82; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_question_user_id_93779a82 ON public.online_test_question USING btree (user_id);


--
-- Name: online_test_questionpaper__questionpaper_id_0669e325; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionpaper__questionpaper_id_0669e325 ON public.online_test_questionpaper_fixed_questions USING btree (questionpaper_id);


--
-- Name: online_test_questionpaper__questionpaper_id_fbcb4bce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionpaper__questionpaper_id_fbcb4bce ON public.online_test_questionpaper_random_questions USING btree (questionpaper_id);


--
-- Name: online_test_questionpaper__questionset_id_7967095f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionpaper__questionset_id_7967095f ON public.online_test_questionpaper_random_questions USING btree (questionset_id);


--
-- Name: online_test_questionpaper_fixed_questions_question_id_97cd0dac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionpaper_fixed_questions_question_id_97cd0dac ON public.online_test_questionpaper_fixed_questions USING btree (question_id);


--
-- Name: online_test_questionpaper_quiz_id_ffa9ae07; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionpaper_quiz_id_ffa9ae07 ON public.online_test_questionpaper USING btree (quiz_id);


--
-- Name: online_test_questionset_questions_question_id_a5c5ce91; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionset_questions_question_id_a5c5ce91 ON public.online_test_questionset_questions USING btree (question_id);


--
-- Name: online_test_questionset_questions_questionset_id_64d21c87; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_questionset_questions_questionset_id_64d21c87 ON public.online_test_questionset_questions USING btree (questionset_id);


--
-- Name: online_test_quiz_creator_id_c607ca3d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX online_test_quiz_creator_id_c607ca3d ON public.online_test_quiz USING btree (creator_id);


--
-- Name: reset_token_reset_token_23a1de31_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reset_token_reset_token_23a1de31_like ON public.reset_token USING btree (reset_token varchar_pattern_ops);


--
-- Name: reset_token_user_id_aae5d20a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reset_token_user_id_aae5d20a ON public.reset_token USING btree (user_id);


--
-- Name: token_key_86d3c722_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_key_86d3c722_like ON public.token USING btree (key varchar_pattern_ops);


--
-- Name: token_user_id_1c65fba4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_user_id_1c65fba4 ON public.token USING btree (user_id);


--
-- Name: user_notification_notification_id_02fe6489; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_notification_notification_id_02fe6489 ON public.user_notification USING btree (notification_id);


--
-- Name: user_notification_user_id_66a31b4a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_notification_user_id_66a31b4a ON public.user_notification USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: confirm_email_token confirm_email_token_user_id_a738242a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.confirm_email_token
    ADD CONSTRAINT confirm_email_token_user_id_a738242a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grades_graderange grades_graderange_system_id_775318a7_fk_grades_gradingsystem_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_graderange
    ADD CONSTRAINT grades_graderange_system_id_775318a7_fk_grades_gradingsystem_id FOREIGN KEY (system_id) REFERENCES public.grades_gradingsystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: grades_gradingsystem grades_gradingsystem_creator_id_b4de4f90_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades_gradingsystem
    ADD CONSTRAINT grades_gradingsystem_creator_id_b4de4f90_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: login_history login_history_user_id_0eeaebb8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_history_user_id_0eeaebb8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answer online_test_answer_question_id_927716e9_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answer
    ADD CONSTRAINT online_test_answer_question_id_927716e9_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_answers online_test_answerpa_answer_id_90cb56fb_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_answers
    ADD CONSTRAINT online_test_answerpa_answer_id_90cb56fb_fk_online_te FOREIGN KEY (answer_id) REFERENCES public.online_test_answer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_answers online_test_answerpa_answerpaper_id_4548dc22_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_answers
    ADD CONSTRAINT online_test_answerpa_answerpaper_id_4548dc22_fk_online_te FOREIGN KEY (answerpaper_id) REFERENCES public.online_test_answerpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions_answered online_test_answerpa_answerpaper_id_723ec781_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_answered
    ADD CONSTRAINT online_test_answerpa_answerpaper_id_723ec781_fk_online_te FOREIGN KEY (answerpaper_id) REFERENCES public.online_test_answerpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions online_test_answerpa_answerpaper_id_a344db1b_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions
    ADD CONSTRAINT online_test_answerpa_answerpaper_id_a344db1b_fk_online_te FOREIGN KEY (answerpaper_id) REFERENCES public.online_test_answerpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions_unanswered online_test_answerpa_answerpaper_id_ab6a4743_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_unanswered
    ADD CONSTRAINT online_test_answerpa_answerpaper_id_ab6a4743_fk_online_te FOREIGN KEY (answerpaper_id) REFERENCES public.online_test_answerpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper online_test_answerpa_course_id_46f0e11a_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper
    ADD CONSTRAINT online_test_answerpa_course_id_46f0e11a_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions_unanswered online_test_answerpa_question_id_1a1fb223_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_unanswered
    ADD CONSTRAINT online_test_answerpa_question_id_1a1fb223_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions_answered online_test_answerpa_question_id_a23a9cde_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions_answered
    ADD CONSTRAINT online_test_answerpa_question_id_a23a9cde_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper_questions online_test_answerpa_question_id_bd87f214_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper_questions
    ADD CONSTRAINT online_test_answerpa_question_id_bd87f214_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper online_test_answerpa_question_paper_id_9038de8b_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper
    ADD CONSTRAINT online_test_answerpa_question_paper_id_9038de8b_fk_online_te FOREIGN KEY (question_paper_id) REFERENCES public.online_test_questionpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_answerpaper online_test_answerpaper_user_id_5eb27486_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_answerpaper
    ADD CONSTRAINT online_test_answerpaper_user_id_5eb27486_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_assignmentupload online_test_assignme_assignmentQuestion_i_84c766bb_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload
    ADD CONSTRAINT "online_test_assignme_assignmentQuestion_i_84c766bb_fk_online_te" FOREIGN KEY ("assignmentQuestion_id") REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_assignmentupload online_test_assignme_course_id_42db3af1_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload
    ADD CONSTRAINT online_test_assignme_course_id_42db3af1_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_assignmentupload online_test_assignme_question_paper_id_9c629ba3_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload
    ADD CONSTRAINT online_test_assignme_question_paper_id_9c629ba3_fk_online_te FOREIGN KEY (question_paper_id) REFERENCES public.online_test_questionpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_assignmentupload online_test_assignmentupload_user_id_32c1e730_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_assignmentupload
    ADD CONSTRAINT online_test_assignmentupload_user_id_32c1e730_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course online_test_course_creator_id_2dd2f14e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course
    ADD CONSTRAINT online_test_course_creator_id_2dd2f14e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course online_test_course_grading_system_id_6c81f560_fk_grades_gr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course
    ADD CONSTRAINT online_test_course_grading_system_id_6c81f560_fk_grades_gr FOREIGN KEY (grading_system_id) REFERENCES public.grades_gradingsystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_learning_module online_test_course_l_course_id_0f5690ee_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_learning_module
    ADD CONSTRAINT online_test_course_l_course_id_0f5690ee_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_learning_module online_test_course_l_learningmodule_id_03e38929_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_learning_module
    ADD CONSTRAINT online_test_course_l_learningmodule_id_03e38929_fk_online_te FOREIGN KEY (learningmodule_id) REFERENCES public.online_test_learningmodule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_requests online_test_course_r_course_id_5ab31b5e_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_requests
    ADD CONSTRAINT online_test_course_r_course_id_5ab31b5e_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_rejected online_test_course_r_course_id_6d4fcc52_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_rejected
    ADD CONSTRAINT online_test_course_r_course_id_6d4fcc52_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_rejected online_test_course_rejected_user_id_be12dedb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_rejected
    ADD CONSTRAINT online_test_course_rejected_user_id_be12dedb_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_requests online_test_course_requests_user_id_ff7444fb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_requests
    ADD CONSTRAINT online_test_course_requests_user_id_ff7444fb_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_students online_test_course_s_course_id_5f69e022_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_students
    ADD CONSTRAINT online_test_course_s_course_id_5f69e022_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_students online_test_course_students_user_id_8760b79b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_students
    ADD CONSTRAINT online_test_course_students_user_id_8760b79b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_teachers online_test_course_t_course_id_8a3e6f07_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_teachers
    ADD CONSTRAINT online_test_course_t_course_id_8a3e6f07_fk_online_te FOREIGN KEY (course_id) REFERENCES public.online_test_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_course_teachers online_test_course_teachers_user_id_4aee6b7e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_course_teachers
    ADD CONSTRAINT online_test_course_teachers_user_id_4aee6b7e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_fileupload online_test_fileuplo_question_id_ebfb4f24_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_fileupload
    ADD CONSTRAINT online_test_fileuplo_question_id_ebfb4f24_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_learningmodule_learning_unit online_test_learning_learningmodule_id_89888508_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule_learning_unit
    ADD CONSTRAINT online_test_learning_learningmodule_id_89888508_fk_online_te FOREIGN KEY (learningmodule_id) REFERENCES public.online_test_learningmodule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_learningmodule_learning_unit online_test_learning_learningunit_id_47e47326_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule_learning_unit
    ADD CONSTRAINT online_test_learning_learningunit_id_47e47326_fk_online_te FOREIGN KEY (learningunit_id) REFERENCES public.online_test_learningunit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_learningunit online_test_learning_lesson_id_8a508fe7_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningunit
    ADD CONSTRAINT online_test_learning_lesson_id_8a508fe7_fk_online_te FOREIGN KEY (lesson_id) REFERENCES public.online_test_lesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_learningunit online_test_learning_quiz_id_c62703e9_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningunit
    ADD CONSTRAINT online_test_learning_quiz_id_c62703e9_fk_online_te FOREIGN KEY (quiz_id) REFERENCES public.online_test_quiz(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_learningmodule online_test_learningmodule_creator_id_5ca797b8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_learningmodule
    ADD CONSTRAINT online_test_learningmodule_creator_id_5ca797b8_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_lesson online_test_lesson_creator_id_44bb41d4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lesson
    ADD CONSTRAINT online_test_lesson_creator_id_44bb41d4_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_lessonfile online_test_lessonfi_lesson_id_1553a7bb_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_lessonfile
    ADD CONSTRAINT online_test_lessonfi_lesson_id_1553a7bb_fk_online_te FOREIGN KEY (lesson_id) REFERENCES public.online_test_lesson(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_profile online_test_profile_user_id_28604d5b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_profile
    ADD CONSTRAINT online_test_profile_user_id_28604d5b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionpaper_fixed_questions online_test_question_question_id_97cd0dac_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_fixed_questions
    ADD CONSTRAINT online_test_question_question_id_97cd0dac_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionset_questions online_test_question_question_id_a5c5ce91_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset_questions
    ADD CONSTRAINT online_test_question_question_id_a5c5ce91_fk_online_te FOREIGN KEY (question_id) REFERENCES public.online_test_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionpaper_fixed_questions online_test_question_questionpaper_id_0669e325_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_fixed_questions
    ADD CONSTRAINT online_test_question_questionpaper_id_0669e325_fk_online_te FOREIGN KEY (questionpaper_id) REFERENCES public.online_test_questionpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionpaper_random_questions online_test_question_questionpaper_id_fbcb4bce_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_random_questions
    ADD CONSTRAINT online_test_question_questionpaper_id_fbcb4bce_fk_online_te FOREIGN KEY (questionpaper_id) REFERENCES public.online_test_questionpaper(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionset_questions online_test_question_questionset_id_64d21c87_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionset_questions
    ADD CONSTRAINT online_test_question_questionset_id_64d21c87_fk_online_te FOREIGN KEY (questionset_id) REFERENCES public.online_test_questionset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionpaper_random_questions online_test_question_questionset_id_7967095f_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper_random_questions
    ADD CONSTRAINT online_test_question_questionset_id_7967095f_fk_online_te FOREIGN KEY (questionset_id) REFERENCES public.online_test_questionset(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_questionpaper online_test_question_quiz_id_ffa9ae07_fk_online_te; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_questionpaper
    ADD CONSTRAINT online_test_question_quiz_id_ffa9ae07_fk_online_te FOREIGN KEY (quiz_id) REFERENCES public.online_test_quiz(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_question online_test_question_user_id_93779a82_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_question
    ADD CONSTRAINT online_test_question_user_id_93779a82_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: online_test_quiz online_test_quiz_creator_id_c607ca3d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.online_test_quiz
    ADD CONSTRAINT online_test_quiz_creator_id_c607ca3d_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reset_token reset_token_user_id_aae5d20a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_token
    ADD CONSTRAINT reset_token_user_id_aae5d20a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token token_user_id_1c65fba4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_user_id_1c65fba4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_notification user_notification_notification_id_02fe6489_fk_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_notification
    ADD CONSTRAINT user_notification_notification_id_02fe6489_fk_notification_id FOREIGN KEY (notification_id) REFERENCES public.notification(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_notification user_notification_user_id_66a31b4a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_notification
    ADD CONSTRAINT user_notification_user_id_66a31b4a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.11 (Debian 10.11-1.pgdg90+1)
-- Dumped by pg_dump version 10.11 (Debian 10.11-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

