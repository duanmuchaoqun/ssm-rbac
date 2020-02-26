<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/22
  Time: 19:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String title = "用户管理";
    pageContext.setAttribute("title",title);
%>
<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${APP_PATH }/static/css/main.css">

<style>
    .tree li {
        list-style-type: none;
        cursor:pointer;
    }
    table tbody tr:nth-child(odd){background:#F4F4F4;}
    table tbody td:nth-child(even){color:#C00;}
</style>



<div class="container-fluid">
    <div class="row">
        <%@ include file="../common/menu.jsp" %>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form id="searchForm" class="form-inline" role="form" style="float:left;" action="${APP_PATH }/user/index" method="get">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" name="username" id="searchName" value="${param.username }" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" id="searchByName"><i class="glyphicon glyphicon-search"></i> 查询</button>

                    </form>
                    <button type="button" class="btn btn-danger" id="deleteBatch" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="goToAdd()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30"><input type="checkbox" id="check_all"></th>
                                <th width="30">id</th>
                                <th>账号</th>
                                <th>用户名称</th>
                                <th>邮箱地址</th>
                                <th>创建时间</th>
                                <th>修改时间</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list }" var="item">
                                <tr>
                                    <td><input type="checkbox" class="check_item" data-id="${item.id }" data-name="${item.username }"></td>
                                    <td>${item.id }</td>
                                    <td>${item.account }</td>
                                    <td>${item.username }</td>
                                    <td>${item.email }</td>
                                    <td><fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${item.updateTime }" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs assign-role" data-id="${item.id } "><i class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs editUser" data-id="${item.id }" ><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" class="btn btn-danger btn-xs delete" data-id="${item.id } "><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="8" align="center">
                                    <ul class="pagination">
                                        <c:if test="${!pageInfo.hasPreviousPage }">
                                            <li class="disabled">
                                                <a >上一页</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${pageInfo.hasPreviousPage }">
                                            <li>
                                                <a href="${APP_PATH }/user/index?pageNum=${pageInfo.prePage }">上一页</a>
                                            </li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums }" var="item">
                                            <c:if test="${pageInfo.pageNum == item }">
                                                <li class="active"><a href="${APP_PATH }/user/index?pageNum=${item }">${item }<span class="sr-only">(current)</span></a></li>
                                            </c:if>
                                            <c:if test="${pageInfo.pageNum != item }">
                                                <li><a href="${APP_PATH }/user/index?pageNum=${item }">${item }</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!pageInfo.hasNextPage }">
                                            <li class="disabled">
                                                <a >下一页</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH }/user/index?pageNum=${pageInfo.nextPage }">下一页</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
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
        $.each($(".pagination a"),function (index,item) {
            var searchName = $("input[name]").val();
            var href = $(item).attr("href");
            if( href!= undefined){
                href = href+"&username="+searchName;
            }
            $(item).attr("href",href);
        });

    });
    function goToAdd() {
        window.location.href="${APP_PATH }/user/add";
    }

    $(".editUser").click(function () {
        var id = $(this).attr("data-id");
        window.location.href="${APP_PATH }/user/edit?id="+id;
    });
    
    $(".delete").click(function () {
        var id = $(this).attr("data-id");
        var username = $(this).parent().parent().find("td:eq(3)").text();
        layer.confirm('是否确认删除'+username+'？', {
            title:"删除记录",
            btn: ['确认','取消'],//按钮
            icon: 3
        }, function(){
            $.ajax({
                url:"${APP_PATH }/user/deleteById",
                type:"POST",
                data:{'id':id},
                success:function (result) {
                    if(result.code == 200){
                        layer.msg(result.message, {
                            icon: 1,
                            time:1000,
                        }, function(){
                            window.location.reload();
                        });

                    } else {
                        layer.msg(result.message, {icon: 2});
                    }
                }

            });

        });
    });


    $("#searchByName").click(function () {
        $("#searchForm").submit();
    });


    //全选与全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(".check_item").click(function () {
        var boxNum = $(".check_item").length;
        if($(".check_item:checked").length == boxNum){
            $("#check_all").prop("checked",true);
        } else {
            $("#check_all").prop("checked",false);
        }
    });
    //批量删除
    $("#deleteBatch").click(function () {
        var items = $(".check_item:checked");
        if(items.length == 0){
            layer.msg("请选择需要删除的记录", {
                    icon: 2,
                    time:2000,
                },function () {

            })
            return false;
        }
        var str = "";
        var names = "";
        $.each(items,function (index,item) {
            str+=$(item).attr("data-id")+"-";
            names+=$(item).attr("data-name")+"-";
        });
        var ids = str.substring(0,str.length-1);
        var nameList = names.substring(0,names.length-1);
        layer.confirm('是否确认删除'+nameList+'？', {
            title:"删除记录",
            btn: ['确认','取消'],//按钮
            icon: 3
        }, function(){
            $.ajax({
                url:"${APP_PATH }/user/deleteUser",
                type:"POST",
                data:{'ids':ids},
                success:function (result) {
                    if(result.code == 200){
                        layer.msg(result.message, {
                            icon: 1,
                            time:1000,
                        }, function(){
                            window.location.reload();
                        });

                    } else {
                        layer.msg(result.message, {icon: 2});
                    }
                }

            });

        });

    });

    //跳转至角色页面
    $(".assign-role").click(function () {
        var id = $(this).attr("data-id");
        window.location.href="${APP_PATH}/user/assignRole?id="+id;
    })



</script>
</body>
</html>

