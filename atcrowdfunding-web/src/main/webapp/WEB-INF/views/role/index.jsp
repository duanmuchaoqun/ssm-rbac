<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/24
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String title = "角色管理";
    pageContext.setAttribute("title",title);
%>
<%@ include file="../common/header.jsp" %>
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
                    <form class="form-inline rolesForm" role="form" style="float:left;" action="${APP_PATH}/user/roles" method="get">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" name="name" type="text" value="${param.name}" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" id="searchBtn"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="goToAdd()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30"><input type="checkbox"></th>
                                <th width="30">id</th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageInfo.list}" var="item">
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>${item.id}</td>
                                        <td>${item.name}</td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-xs assign_btn" data-id="${item.id}"><i class=" glyphicon glyphicon-check"></i></button>
                                            <button type="button" class="btn btn-primary btn-xs edit_btn" data-id="${item.id}"><i class=" glyphicon glyphicon-pencil"></i></button>
                                            <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:if test="${!pageInfo.hasPreviousPage }">
                                            <li class="disabled">
                                                <a >上一页</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${pageInfo.hasPreviousPage }">
                                            <li>
                                                <a href="${APP_PATH }/user/roles?pageNum=${pageInfo.prePage }">上一页</a>
                                            </li>
                                        </c:if>
                                        <c:forEach items="${pageInfo.navigatepageNums }" var="item">
                                            <c:if test="${pageInfo.pageNum == item }">
                                                <li class="active"><a href="${APP_PATH }/user/roles?pageNum=${item }">${item }<span class="sr-only">(current)</span></a></li>
                                            </c:if>
                                            <c:if test="${pageInfo.pageNum != item }">
                                                <li><a href="${APP_PATH }/user/roles?pageNum=${item }">${item }</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!pageInfo.hasNextPage }">
                                            <li class="disabled">
                                                <a >下一页</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${pageInfo.hasNextPage }">
                                            <li>
                                                <a href="${APP_PATH }/user/roles?pageNum=${pageInfo.nextPage }">下一页</a>
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
                href = href+"&name="+searchName;
            }
            $(item).attr("href",href);
        });
    });
    $("#searchBtn").click(function () {
        $(".rolesForm").submit();
    });
    function goToAdd() {
        window.location.href="${APP_PATH }/user/addRoles";
    }
    $(".edit_btn").click(function () {

        window.location.href="${APP_PATH }/user/editRoles?id="+$(this).attr("data-id");
    });
    $(".assign_btn").click(function () {
        window.location.href="${APP_PATH }/permission/assignPermission?id="+$(this).attr("data-id");
    })
</script>
</body>
</html>
