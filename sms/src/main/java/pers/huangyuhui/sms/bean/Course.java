package pers.huangyuhui.sms.bean;

/**
 * @BelongsProject:sms
 * @BelongsPackage:pers.huangyuhui.sms.bean
 * @Author:HDS-studio
 * @CreateTime:2020-05-23 23:33
 * @Description:课程表
 */
public class Course {
    private Integer id;
    private String name;
    private String teacher_name;
//
//    //一个课程只能由一名老师教
//    private Teacher teacher;
//    //一个课程有多名学生
//    private Student student;

    public String getTeacher_name() {
        return teacher_name;
    }

    public void setTeacher_name(String teacher_name) {
        this.teacher_name = teacher_name;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

//    public void setTeacher(Teacher teacher) {
//        this.teacher = teacher;
//    }
//
//    public void setStudent(Student student) {
//        this.student = student;
//    }

    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
