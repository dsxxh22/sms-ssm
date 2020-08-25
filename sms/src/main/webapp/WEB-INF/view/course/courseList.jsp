<%--
  Created by IntelliJ IDEA.
  User: 黄宇辉
  Date: 6/18/2019
  Time: 9:37 AM
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8" content="#">
    <title>课程信息管理页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/demo.css">
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/js/validateExtends.js"></script>

    <script type="text/javascript">
        //DOM加载完成后执行的回调函数
        $(function () {
            var table;
            //初始化datagrid
            $('#dataList').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "getCourseList" ,
                idField: 'id',
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 50},
                    {field: 'id', title: 'ID', width: 50, sortable: true},
                    {field: 'teacher_name', title: '任课老师', width: 150},
                    {field: 'name', title: '课程名', width: 150},
                ]],
                toolbar: "#toolbar"//工具栏
            });

            //设置分页控件
            var p = $('#dataList').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//设置每页显示的记录条数,默认为10
                pageList: [10, 20, 30, 50, 100],//设置每页记录的条数
                beforePageText: '第',
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            });

            //信息添加按钮事件
            $("#add").click(function () {
                table = $("#addTable");
                $("#addTable").form("clear");//清空表单数据
                $("#addDialog").dialog("open");//打开添加窗口
            });

            //信息修改按钮事件
            $("#edit").click(function () {
                table = $("#editTable");
                var selectRows = $("#dataList").datagrid("getSelections");
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
                } else {
                    $("#editDialog").dialog("open");
                }
            });

            //信息删除按钮事件
            $("#delete").click(function () {
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据哟!", "warning");
                } else {
                    var ids = [];
                    $(selectRows).each(function (i, row) {
                        ids[i] = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该课程信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "deleteCourse?t" + new Date().getTime(),
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.success) {
                                        $.messager.alert("消息提醒", "删除成功啦!", "info");
                                        $("#dataList").datagrid("reload");//刷新表格
                                        $("#dataList").datagrid("uncheckAll");//取消勾选当前页所有的行
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });

            //设置添加课程信息窗口
            $("#addDialog").dialog({
                title: "添加课程信息窗口",
                width: 660,
                height: 470,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '添加',
                        plain: true,
                        iconCls: 'icon-add',
                        handler: function () {
                            var validate = $("#addForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#addForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "addCourse?t" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            $("#addDialog").dialog("close"); //关闭窗口
                                            $('#dataList').datagrid("reload");//重新刷新页面数据
                                            $.messager.alert("消息提醒", "添加成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {

                            $("#add_name").textbox('setValue', "");

                            $("#add_teachername").textbox('setValue', "");
                        }
                    }
                ]
            });

            //设置编辑课程信息窗口
            $("#editDialog").dialog({
                title: "修改课程信息窗口",
                width: 660,
                height: 430,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#editForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "editCourse?t=" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            //关闭窗口
                                            $("#editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $('#dataList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert("消息提醒", "修改成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#edit_name").textbox('setValue', "");

                            $("#edit_teachername").textbox('setValue', "");
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");
                    $("#edit_id").val(selectRow.id);//初始化id值,需根据id更新信息

                    $("#edit_name").textbox('setValue', selectRow.name);

                    $("#edit_teachername").textbox('setValue', selectRow.teacher_name);

                }
            });

            //教师与班级名搜索按钮的监听事件(将其值返回给Controller)
            $("#search-btn").click(function () {
                $('#dataList').datagrid('load', {
                    coursename: $('#search-coursename').val()//获取课程名称
                });
            });

            //学生选课按钮事件
            $("#makeadd").click(function () {
                table = $("#makeaddTable");
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要选课的数据哟!", "warning");
                } else {
                    $("#makeaddDialog").dialog("open");
                }
            });

            //核对课程信息窗口
            $("#makeaddDialog").dialog({
                title: "核对课程信息窗口",
                width: 660,
                height: 430,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#makeaddForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#makeaddForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "makeaddCourse?t=" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            //关闭窗口
                                            $("#makeaddDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $('#dataList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert("消息提醒", "选课成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    }

                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");
                    //var username=${userInfo.name};
                    $("#makeadd_id").val(selectRow.id);//初始化id值,需根据id更新信息

                    $("#makeadd_name").textbox('setValue', selectRow.name);


                }
            });
        });
    </script>
</head>
<body>

<!-- 课程列表信息 -->
<table id="dataList" cellspacing="0" cellpadding="0"></table>

<!-- 工具栏 -->
<div id="toolbar">

    <%-- 通过JSTL设置用户操作权限: 将修改和删除按钮设置为仅管理员可见 --%>
    <c:if test="${userType==1}">
        <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-add',plain:true">添加</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>

        <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-edit',plain:true">修改</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
    </c:if>
    <c:if test="${userType==2}">
        <div style="float: left;"><a id="makeadd" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-add',plain:true">选课</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>
    </c:if>



    <!-- 教师,课程名搜索域 -->
    <div style="margin-left: 10px;">
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <!-- 教师名称下拉框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-class',plain:true">教师名称</a>
        <select id="search-teachername" style="width: 155px;" class="easyui-combobox" name="teachername">
            <!-- 通过JSTL遍历显示教师信息,teacherList:为Contrller传递的来的,存储着Teacher的List对象 -->
            <option value="">未选择教师</option>
            <c:forEach items="${teacherList}" var="teacher">
                <option value="${teacher.name}">${teacher.name}</option>
            </c:forEach>
        </select>
        <!-- 课程名搜索框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-user-teacher',plain:true">课程名称</a>
        <input id="search-coursename" class="easyui-textbox" name="coursename"/>
        <!-- 搜索按钮 -->
        <a id="search-btn" href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',plain:true">搜索</a>
    </div>
</div>

<!-- 添加信息窗口 -->
<div id="addDialog" style="padding: 15px 0 0 55px;">

    <!-- 课程信息表单 -->
    <form id="addForm" method="post" action="#">
        <table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr>
                <td>任课教师</td>
                <td colspan="1">
                    <select id="add_teachername" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="teacher_name" data-options="required:true, missingMessage:'请选择所属任课教师哟~'">
                        <c:forEach items="${teacherList}" var="teacher">
                            <option value="${teacher.name}">${teacher.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>课程名</td>
                <td colspan="1">
                    <input id="add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="name" data-options="required:true, missingMessage:'请填写课程名哟~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>


<!-- 修改信息窗口 -->
<div id="editDialog" style="padding: 20px 0 0 65px">

    <!-- 课程信息表单 -->
    <form id="editForm" method="post" action="#">
        <!-- 获取被修改信息的教师id -->
        <input type="hidden" id="edit_id" name="id"/>
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr>
                <td>任课教师</td>
                <td colspan="1">
                    <select id="edit_teachername" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="teacher_name">
                        <c:forEach items="${teacherList}" var="teacher">
                            <option value="${teacher.name}">${teacher.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>课程名</td>
                <td colspan="1">
                    <input id="edit_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="name" data-options="required:true, missingMessage:'请填写课程名哟~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 核对信息窗口 -->
<div id="makeaddDialog" style="padding: 20px 0 0 65px">

    <!-- 课程信息表单 -->
    <form id="makeaddForm" method="post" action="#">
        <!-- 获取被修改信息的id -->
        <input type="hidden" id="makeadd_id" name="id"/>
        <table id="makeaddTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>选课学生</td>

                <td colspan="1">
                    <input id="makeadd_username" style="width: 200px; height: 30px;" class="easyui-textbox" value="${userInfo.name}"
                           type="text" name="student_name" data-options="required:true, missingMessage:'请填写课程名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>课程名</td>
                <td colspan="1">
                    <input id="makeadd_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="course_name" data-options="required:true, missingMessage:'请填写课程名哟~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 表单处理 -->
<iframe id="photo_target" name="photo_target" onload="uploaded(this)"></iframe>

</body>
</html>
