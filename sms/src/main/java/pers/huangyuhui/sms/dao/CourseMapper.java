package pers.huangyuhui.sms.dao;

import pers.huangyuhui.sms.bean.Course;
import pers.huangyuhui.sms.bean.Sc;

import java.util.List;

/**
 * @BelongsProject:sms
 * @BelongsPackage:pers.huangyuhui.sms.dao
 * @Author:HDS-studio
 * @CreateTime:2020-05-24 00:52
 * @Description:
 */
public interface CourseMapper {
    List<Course> selectList(Course coursename);

    int update(Course course);

    Course findByCname(Course course);

    int insert(Course course);

    int deleteById(Integer[] ids);


    int makeadd(Sc sc);

    Sc findByScname(Sc sc);

    List<Sc> selectScList(Sc coursename);

    int updatesc(Sc sc);

    int insertsc(Sc sc);

    int deleteByScId(Integer[] ids);
}
