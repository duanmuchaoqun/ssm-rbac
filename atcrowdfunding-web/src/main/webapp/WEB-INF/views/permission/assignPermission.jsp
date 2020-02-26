<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/25
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String title = "许可管理";
    pageContext.setAttribute("title",title);
%>
<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${APP_PATH}/static/ztree/zTreeStyle.css">
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

            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限分配列表<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <button class="btn btn-success" onclick="doAssign()">分配许可</button>
                    <br><br>
                    <ul id="treeDemo" class="ztree"></ul>
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
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
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
<script src="${APP_PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
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

        var setting = {
            check : {
                enable : true
            },
            async: {
                enable: true,
                url:"${APP_PATH}/permission/getAssignPermissions?roleId="+${param.id},
                autoParam:["id", "name=n", "level=lv"]
            },
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + treeNode.icon).css("background","");
                    }
                },
            },
            callback: {
                onClick : function(event, treeId, json) {

                }
            }
        };
        //$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据

        $.fn.zTree.init($("#treeDemo"), setting);
    });
    function getPerData() {
        var returnVal;
        $.ajax({
            url:"${APP_PATH}/permission/getPermissions",
            async:false,
            type:"get",
            success:function (result) {
                returnVal = result.data.list;
            }
        });
        return returnVal;
    }
    function doAssign() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);
        if(nodes.length == 0){
            layer.msg("请选择需要分配的许可信息",{time:2000,icon:5,shift:6},function () {
                
            })
        } else {
            var d = "roleId=${param.id}";
            $.each(nodes,function (index,node) {
                d +="&permissionIds="+node.id
            });
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/permission/doAssign",
                data:d,
                success:function (result) {
                    if(result.code == 200){
                        layer.msg("分配成功",{icon:1})
                    } else {
                        layer.msg("分配失败",{icon:2})
                    }
                }
            })
        }
    }
</script>
</body>
</html>

