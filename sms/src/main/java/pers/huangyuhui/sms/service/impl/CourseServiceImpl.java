package pers.huangyuhui.sms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pers.huangyuhui.sms.bean.Course;
import pers.huangyuhui.sms.bean.Sc;
import pers.huangyuhui.sms.bean.Teacher;
import pers.huangyuhui.sms.dao.*;
import pers.huangyuhui.sms.service.CourseService;

import java.util.List;

/**
 * @BelongsProject:sms
 * @BelongsPackage:pers.huangyuhui.sms.service.impl
 * @Author:HDS-studio
 * @CreateTime:2020-05-24 00:47
 * @Description:
 */

@Service
@Transactional
public class CourseServiceImpl implements CourseService {

    //注入Mapper接口对象
    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<Course> selectList(Course coursename) {
        return courseMapper.selectList(coursename);
    }

    @Override
    public int update(Course course) {
        return courseMapper.update(course);
    }

    @Override
    public Course findByCname(Course course){
        return courseMapper.findByCname(course);
    }

    @Override
    public int insert(Course course) {
        return courseMapper.insert(course);
    }

    @Override
    public int deleteById(Integer[] ids) {
        return courseMapper.deleteById(ids);
    }



    @Override
    public int makeadd(Sc sc) {
        return courseMapper.makeadd(sc);
    }

    @Override
    public Sc findByScname(Sc sc) {
        return courseMapper.findByScname(sc);
    }

    @Override
    public List<Sc> selectScList(Sc coursename) {
        return courseMapper.selectScList(coursename);
    }

    @Override
    public int updatesc(Sc sc)  {
        return courseMapper.updatesc(sc);
    }

    @Override
    public int insertsc(Sc sc) {
        return courseMapper.insertsc(sc);
    }

    @Override
    public int deleteByScId(Integer[] ids)  {
        return courseMapper.deleteByScId(ids);
    }


}
