package pers.huangyuhui.sms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import pers.huangyuhui.sms.bean.Course;
import pers.huangyuhui.sms.bean.Sc;
import pers.huangyuhui.sms.bean.Teacher;
import pers.huangyuhui.sms.service.CourseService;
import pers.huangyuhui.sms.service.StudentService;
import pers.huangyuhui.sms.service.TeacherService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @BelongsProject:sms
 * @BelongsPackage:pers.huangyuhui.sms.controller
 * @Author:HDS-studio
 * @CreateTime:2020-05-23 23:48
 * @Description:课程
 */

@Controller
@RequestMapping("/course")
public class CourseController {

    //注入业务对象
    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private CourseService courseService;

    //存储预返回页面的数据对象
    private Map<String, Object> result = new HashMap<>();

    /**
     * 跳转到课程信息管理
     */
    @GetMapping("/goCourseListView")
    private ModelAndView goCourseListView(ModelAndView modelAndView) {
        //向页面发送一个存储着User的List对象
        modelAndView.addObject("teacherList", teacherService.selectAll());
        modelAndView.setViewName("course/courseList");
        return modelAndView;

    }

    @PostMapping("/getCourseList")
    @ResponseBody
    public Map<String, Object> getCourseList(Integer page, Integer rows, String coursename) {

        //存储查询的coursename,teachername信息
        Course course = new Course();
        course.setName(coursename);
        //设置每页的记录数l
        PageHelper.startPage(page, rows);
        //根据班级与教师名获取指定或全部教师信息列表
        List<Course> list = courseService.selectList(course);
        //封装列表信息
        PageInfo<Course> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Course> courseList = pageInfo.getList();
        //存储数据对象
        result.put("total", total);
        result.put("rows", courseList);

        return result;
    }

    @PostMapping("/editCourse")
    @ResponseBody
    public Map<String, Object> editCourse(Course course) {
        if (courseService.update(course) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "修改失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/addCourse")
    @ResponseBody
    public Map<String, Object> addCourse(Course course) {
        //判断是否已存在
        if (courseService.findByCname(course) != null) {
            result.put("success", false);
            result.put("msg", "课程已存在! 请修改后重试!");
            return result;
        }
        if (courseService.insert(course) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/deleteCourse")
    @ResponseBody
    public Map<String, Object> deleteCourse(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (courseService.deleteById(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "删除失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/makeaddCourse")
    @ResponseBody
    public Map<String, Object> makeaddCourse(Sc sc) {

        //判断是否已存在
        if (courseService.findByScname(sc) != null) {
            result.put("success", false);
            result.put("msg", "该课程已选! 请重新选择!");
            return result;
        }

        if (courseService.makeadd(sc) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "选课失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @GetMapping("/goScListView")
    private ModelAndView goScListView(ModelAndView modelAndView) {
        //向页面发送一个存储着User的List对象
        modelAndView.addObject("teacherList", teacherService.selectAll());
        modelAndView.setViewName("course/scList");
        return modelAndView;

    }

    @PostMapping("/getScList")
    @ResponseBody
    public Map<String, Object> getScList(Integer page, Integer rows,String coursename) {

        //存储查询的coursename,teachername信息
//        Course course = new Course();
//        course.setName(coursename);
        Sc sc = new Sc();
        sc.setCourse_name(coursename);
        //设置每页的记录数l
        PageHelper.startPage(page, rows);
        //获取指定或全部选课信息列表
        List<Sc> list = courseService.selectScList(sc);
        //封装列表信息
        PageInfo<Sc> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Sc> scList = pageInfo.getList();
        //存储数据对象
        result.put("total", total);
        result.put("rows", scList);

        return result;
    }

    @PostMapping("/editSc")
    @ResponseBody
    public Map<String, Object> editSc(Sc sc) {
        if (courseService.updatesc(sc) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "修改失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/addSc")
    @ResponseBody
    public Map<String, Object> addSc(Sc sc) {
        //判断是否已存在
        if (courseService.findByScname(sc) != null) {
            result.put("success", false);
            result.put("msg", "课程已存在! 请修改后重试!");
            return result;
        }
        if (courseService.insertsc(sc) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/deleteSc")
    @ResponseBody
    public Map<String, Object> deleteSc(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (courseService.deleteByScId(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "删除失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }









}
