<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/24
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String title = "角色管理";
    pageContext.setAttribute("title",title);
%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .tree li {
        list-style-type: none;
        cursor:pointer;
    }
</style>
<div class="container-fluid">
    <div class="row">
        <%@ include file="../common/menu.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline " id="roleForm">
                        <input type="hidden" name="userId" value="${param.id}" id="user_id">
                        <div class="form-group">
                            <label >未分配角色列表</label><br>
                            <select name="unAssignRoleIds" class="form-control"  multiple size="10" style="width:250px;overflow-y:auto;" id="left-roles">
                                <c:forEach items="${unAssignRole}" var="item">
                                    <option value="${item.id}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li class="btn btn-default glyphicon glyphicon-chevron-right" id="choose-right"></li>
                                <br>
                                <li class="btn btn-default glyphicon glyphicon-chevron-left" id="choose-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label >已分配角色列表</label><br>
                            <select name="assignRoleIds" class="form-control" multiple size="10" style="width:250px;overflow-y:auto;" id="right-roles">
                                <c:forEach items="${assignRole}" var="item">
                                    <option value="${item.id}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
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
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
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
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    $("#choose-right").click(function () {
        var opts = $("#left-roles :selected");
        if(opts.length == 0){
            layer.msg("请选择所需要分配的角色",{icon:2});
            return false;
        } else {
            $.ajax({
                url:"${APP_PATH}/user/doAssignRole",
                type:"POST",
                data:$("#roleForm").serialize(),
                success:function (result) {
                    if(result.code == 200){
                        $("#right-roles").append(opts);
                    }
                }
            });
        }

    });
    $("#choose-left").click(function () {
        var opts = $("#right-roles :selected");
        if(opts.length == 0){
            layer.msg("请选择所需要取消的角色",{icon:2});
            return false;
        } else {
            $.ajax({
                url:"${APP_PATH}/user/doUnAssignRole",
                type:"POST",
                data:$("#roleForm").serialize(),
                success:function (result) {
                    if(result.code == 200){
                        $("#left-roles").append(opts);
                    }
                }
            });
        }
    })
</script>
</body>
</html>
