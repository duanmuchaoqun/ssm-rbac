<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/25
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String title = "角色管理";
    pageContext.setAttribute("title",title);
%>
<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${APP_PATH }/static/validform/css/validform.css">
<style>
    .tree li {
        list-style-type: none;
        cursor: pointer;
    }
</style>

<div class="container-fluid">
    <div class="row">
        <%@ include file="../common/menu.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form role="form" class="userForm">
                        <div class="form-group">
                            <span>
                                <label for="name">角色名称</label>
                                <input type="hidden" name="id" value="${role.id}" />
                                <input type="text" class="form-control" name="name" id="name" value="${role.name}"
                                       datatype="/^[\s*-_a-zA-Z0-9\u4E00-\u9FA5]+$/"
                                       nullmsg="请输入角色名称！" errormsg="角色名称为中文、英文字母、数字、下划线、空格的组合！" placeholder="请输入角色名称">
                            </span>
                            <span></span>
                        </div>
                        <button type="button" class="btn btn-success" id="btn_sub"><i class="glyphicon glyphicon-plus"
                        ></i> 修改
                        </button>
                        <button type="button" class="btn btn-danger" id="reset_form"><i class="glyphicon glyphicon-refresh"></i> 重置
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript" src="${APP_PATH }/static/validform/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    /**
     * 校验并提交
     *
     */
    $(".userForm").Validform({
        tiptype: 2,
        btnSubmit:"#btn_sub",
        callback:function(data){
            $.ajax({
                url:"${APP_PATH }/user/updateRole",
                type:"POST",
                data:$(".userForm").serialize(),
                success:function (result) {
                    if(result.code == 200){
                        window.location.href="${APP_PATH }/user/roles";
                    } else {
                        layer.msg(result.message,{icon:2})
                    }
                }
            });
            return false;
        }
    });

    $("#reset_form").click(function () {
        $(".userForm")[0].reset();
    });



</script>
</body>
</html>
