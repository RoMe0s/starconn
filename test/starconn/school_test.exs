defmodule Starconn.SchoolTest do
  use Starconn.DataCase

  alias Starconn.School

  describe "organizations" do
    alias Starconn.School.Organization

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert School.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert School.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = School.create_organization(@valid_attrs)
      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = School.update_organization(organization, @update_attrs)
      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_organization(organization, @invalid_attrs)
      assert organization == School.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = School.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> School.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = School.change_organization(organization)
    end
  end

  describe "teachers" do
    alias Starconn.School.Teacher

    @valid_attrs %{organization_id: 42, user_id: 42}
    @update_attrs %{organization_id: 43, user_id: 43}
    @invalid_attrs %{organization_id: nil, user_id: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert School.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert School.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = School.create_teacher(@valid_attrs)
      assert teacher.organization_id == 42
      assert teacher.user_id == 42
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = School.update_teacher(teacher, @update_attrs)
      assert teacher.organization_id == 43
      assert teacher.user_id == 43
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_teacher(teacher, @invalid_attrs)
      assert teacher == School.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = School.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> School.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = School.change_teacher(teacher)
    end
  end

  describe "timetables" do
    alias Starconn.School.Timetable

    @valid_attrs %{default: true, name: "some name"}
    @update_attrs %{default: false, name: "some updated name"}
    @invalid_attrs %{default: nil, name: nil}

    def timetable_fixture(attrs \\ %{}) do
      {:ok, timetable} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_timetable()

      timetable
    end

    test "list_timetables/0 returns all timetables" do
      timetable = timetable_fixture()
      assert School.list_timetables() == [timetable]
    end

    test "get_timetable!/1 returns the timetable with given id" do
      timetable = timetable_fixture()
      assert School.get_timetable!(timetable.id) == timetable
    end

    test "create_timetable/1 with valid data creates a timetable" do
      assert {:ok, %Timetable{} = timetable} = School.create_timetable(@valid_attrs)
      assert timetable.default == true
      assert timetable.name == "some name"
    end

    test "create_timetable/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_timetable(@invalid_attrs)
    end

    test "update_timetable/2 with valid data updates the timetable" do
      timetable = timetable_fixture()
      assert {:ok, %Timetable{} = timetable} = School.update_timetable(timetable, @update_attrs)
      assert timetable.default == false
      assert timetable.name == "some updated name"
    end

    test "update_timetable/2 with invalid data returns error changeset" do
      timetable = timetable_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_timetable(timetable, @invalid_attrs)
      assert timetable == School.get_timetable!(timetable.id)
    end

    test "delete_timetable/1 deletes the timetable" do
      timetable = timetable_fixture()
      assert {:ok, %Timetable{}} = School.delete_timetable(timetable)
      assert_raise Ecto.NoResultsError, fn -> School.get_timetable!(timetable.id) end
    end

    test "change_timetable/1 returns a timetable changeset" do
      timetable = timetable_fixture()
      assert %Ecto.Changeset{} = School.change_timetable(timetable)
    end
  end

  describe "timetable_days" do
    alias Starconn.School.TimetableDay

    @valid_attrs %{number: 42, timetable_id: 42}
    @update_attrs %{number: 43, timetable_id: 43}
    @invalid_attrs %{number: nil, timetable_id: nil}

    def timetable_day_fixture(attrs \\ %{}) do
      {:ok, timetable_day} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_timetable_day()

      timetable_day
    end

    test "list_timetable_days/0 returns all timetable_days" do
      timetable_day = timetable_day_fixture()
      assert School.list_timetable_days() == [timetable_day]
    end

    test "get_timetable_day!/1 returns the timetable_day with given id" do
      timetable_day = timetable_day_fixture()
      assert School.get_timetable_day!(timetable_day.id) == timetable_day
    end

    test "create_timetable_day/1 with valid data creates a timetable_day" do
      assert {:ok, %TimetableDay{} = timetable_day} = School.create_timetable_day(@valid_attrs)
      assert timetable_day.number == 42
      assert timetable_day.timetable_id == 42
    end

    test "create_timetable_day/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_timetable_day(@invalid_attrs)
    end

    test "update_timetable_day/2 with valid data updates the timetable_day" do
      timetable_day = timetable_day_fixture()
      assert {:ok, %TimetableDay{} = timetable_day} = School.update_timetable_day(timetable_day, @update_attrs)
      assert timetable_day.number == 43
      assert timetable_day.timetable_id == 43
    end

    test "update_timetable_day/2 with invalid data returns error changeset" do
      timetable_day = timetable_day_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_timetable_day(timetable_day, @invalid_attrs)
      assert timetable_day == School.get_timetable_day!(timetable_day.id)
    end

    test "delete_timetable_day/1 deletes the timetable_day" do
      timetable_day = timetable_day_fixture()
      assert {:ok, %TimetableDay{}} = School.delete_timetable_day(timetable_day)
      assert_raise Ecto.NoResultsError, fn -> School.get_timetable_day!(timetable_day.id) end
    end

    test "change_timetable_day/1 returns a timetable_day changeset" do
      timetable_day = timetable_day_fixture()
      assert %Ecto.Changeset{} = School.change_timetable_day(timetable_day)
    end
  end

  describe "timetable_hours" do
    alias Starconn.School.TimetableHour

    @valid_attrs %{day_id: 42, from: ~T[14:00:00], to: ~T[14:00:00]}
    @update_attrs %{day_id: 43, from: ~T[15:01:01], to: ~T[15:01:01]}
    @invalid_attrs %{day_id: nil, from: nil, to: nil}

    def timetable_hour_fixture(attrs \\ %{}) do
      {:ok, timetable_hour} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_timetable_hour()

      timetable_hour
    end

    test "list_timetable_hours/0 returns all timetable_hours" do
      timetable_hour = timetable_hour_fixture()
      assert School.list_timetable_hours() == [timetable_hour]
    end

    test "get_timetable_hour!/1 returns the timetable_hour with given id" do
      timetable_hour = timetable_hour_fixture()
      assert School.get_timetable_hour!(timetable_hour.id) == timetable_hour
    end

    test "create_timetable_hour/1 with valid data creates a timetable_hour" do
      assert {:ok, %TimetableHour{} = timetable_hour} = School.create_timetable_hour(@valid_attrs)
      assert timetable_hour.day_id == 42
      assert timetable_hour.from == ~T[14:00:00]
      assert timetable_hour.to == ~T[14:00:00]
    end

    test "create_timetable_hour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_timetable_hour(@invalid_attrs)
    end

    test "update_timetable_hour/2 with valid data updates the timetable_hour" do
      timetable_hour = timetable_hour_fixture()
      assert {:ok, %TimetableHour{} = timetable_hour} = School.update_timetable_hour(timetable_hour, @update_attrs)
      assert timetable_hour.day_id == 43
      assert timetable_hour.from == ~T[15:01:01]
      assert timetable_hour.to == ~T[15:01:01]
    end

    test "update_timetable_hour/2 with invalid data returns error changeset" do
      timetable_hour = timetable_hour_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_timetable_hour(timetable_hour, @invalid_attrs)
      assert timetable_hour == School.get_timetable_hour!(timetable_hour.id)
    end

    test "delete_timetable_hour/1 deletes the timetable_hour" do
      timetable_hour = timetable_hour_fixture()
      assert {:ok, %TimetableHour{}} = School.delete_timetable_hour(timetable_hour)
      assert_raise Ecto.NoResultsError, fn -> School.get_timetable_hour!(timetable_hour.id) end
    end

    test "change_timetable_hour/1 returns a timetable_hour changeset" do
      timetable_hour = timetable_hour_fixture()
      assert %Ecto.Changeset{} = School.change_timetable_hour(timetable_hour)
    end
  end

  describe "classes" do
    alias Starconn.School.Class

    @valid_attrs %{key: "some key", name: "some name", organization_id: 42, teacher_id: 42, timetable_id: 42}
    @update_attrs %{key: "some updated key", name: "some updated name", organization_id: 43, teacher_id: 43, timetable_id: 43}
    @invalid_attrs %{key: nil, name: nil, organization_id: nil, teacher_id: nil, timetable_id: nil}

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert School.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert School.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = School.create_class(@valid_attrs)
      assert class.key == "some key"
      assert class.name == "some name"
      assert class.organization_id == 42
      assert class.teacher_id == 42
      assert class.timetable_id == 42
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, %Class{} = class} = School.update_class(class, @update_attrs)
      assert class.key == "some updated key"
      assert class.name == "some updated name"
      assert class.organization_id == 43
      assert class.teacher_id == 43
      assert class.timetable_id == 43
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_class(class, @invalid_attrs)
      assert class == School.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = School.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> School.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = School.change_class(class)
    end
  end

  describe "students" do
    alias Starconn.School.Student

    @valid_attrs %{class_id: 42, price: 120.5, user_id: 42}
    @update_attrs %{class_id: 43, price: 456.7, user_id: 43}
    @invalid_attrs %{class_id: nil, price: nil, user_id: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert School.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert School.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = School.create_student(@valid_attrs)
      assert student.class_id == 42
      assert student.price == 120.5
      assert student.user_id == 42
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = School.update_student(student, @update_attrs)
      assert student.class_id == 43
      assert student.price == 456.7
      assert student.user_id == 43
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_student(student, @invalid_attrs)
      assert student == School.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = School.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> School.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = School.change_student(student)
    end
  end

  describe "lessons" do
    alias Starconn.School.Lesson

    @valid_attrs %{class_id: 42, date: ~D[2010-04-17], from: ~T[14:00:00], payload: "some payload", student_id: 42, teacher_id: 42, to: ~T[14:00:00]}
    @update_attrs %{class_id: 43, date: ~D[2011-05-18], from: ~T[15:01:01], payload: "some updated payload", student_id: 43, teacher_id: 43, to: ~T[15:01:01]}
    @invalid_attrs %{class_id: nil, date: nil, from: nil, payload: nil, student_id: nil, teacher_id: nil, to: nil}

    def lesson_fixture(attrs \\ %{}) do
      {:ok, lesson} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_lesson()

      lesson
    end

    test "list_lessons/0 returns all lessons" do
      lesson = lesson_fixture()
      assert School.list_lessons() == [lesson]
    end

    test "get_lesson!/1 returns the lesson with given id" do
      lesson = lesson_fixture()
      assert School.get_lesson!(lesson.id) == lesson
    end

    test "create_lesson/1 with valid data creates a lesson" do
      assert {:ok, %Lesson{} = lesson} = School.create_lesson(@valid_attrs)
      assert lesson.class_id == 42
      assert lesson.date == ~D[2010-04-17]
      assert lesson.from == ~T[14:00:00]
      assert lesson.payload == "some payload"
      assert lesson.student_id == 42
      assert lesson.teacher_id == 42
      assert lesson.to == ~T[14:00:00]
    end

    test "create_lesson/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_lesson(@invalid_attrs)
    end

    test "update_lesson/2 with valid data updates the lesson" do
      lesson = lesson_fixture()
      assert {:ok, %Lesson{} = lesson} = School.update_lesson(lesson, @update_attrs)
      assert lesson.class_id == 43
      assert lesson.date == ~D[2011-05-18]
      assert lesson.from == ~T[15:01:01]
      assert lesson.payload == "some updated payload"
      assert lesson.student_id == 43
      assert lesson.teacher_id == 43
      assert lesson.to == ~T[15:01:01]
    end

    test "update_lesson/2 with invalid data returns error changeset" do
      lesson = lesson_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_lesson(lesson, @invalid_attrs)
      assert lesson == School.get_lesson!(lesson.id)
    end

    test "delete_lesson/1 deletes the lesson" do
      lesson = lesson_fixture()
      assert {:ok, %Lesson{}} = School.delete_lesson(lesson)
      assert_raise Ecto.NoResultsError, fn -> School.get_lesson!(lesson.id) end
    end

    test "change_lesson/1 returns a lesson changeset" do
      lesson = lesson_fixture()
      assert %Ecto.Changeset{} = School.change_lesson(lesson)
    end
  end

  describe "payments" do
    alias Starconn.School.Payment

    @valid_attrs %{amount: 120.5, lesson_id: 42, note: "some note"}
    @update_attrs %{amount: 456.7, lesson_id: 43, note: "some updated note"}
    @invalid_attrs %{amount: nil, lesson_id: nil, note: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert School.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert School.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = School.create_payment(@valid_attrs)
      assert payment.amount == 120.5
      assert payment.lesson_id == 42
      assert payment.note == "some note"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = School.update_payment(payment, @update_attrs)
      assert payment.amount == 456.7
      assert payment.lesson_id == 43
      assert payment.note == "some updated note"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_payment(payment, @invalid_attrs)
      assert payment == School.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = School.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> School.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = School.change_payment(payment)
    end
  end
end
