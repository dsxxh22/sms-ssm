package pers.huangyuhui.sms.bean;

/**
 * @BelongsProject:sms
 * @BelongsPackage:pers.huangyuhui.sms.bean
 * @Author:HDS-studio
 * @CreateTime:2020-05-24 19:59
 * @Description:选课表
 */
public class Sc {
    private Integer id;
    private String student_name;
    private String course_name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudent_name() {
        return student_name;
    }

    public void setStudent_name(String student_name) {
        this.student_name = student_name;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }
}
