<%--
  Created by IntelliJ IDEA.
  User: menpg
  Date: 2015/3/2
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>服务规则查询</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">

        $(document).ready(function() {
            //图片查看
            $('.showimg').fancyzoom({
                Speed: 400,
                showoverlay: false,
                imgDir: '${ctxStatic}/jquery-fancyzoom/ressources/'
            });
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $.jBox.tip("正在刷新列表，请稍等",'loading',{opacity:0});
            $("#searchForm").submit();
            return false;
        }
        //显示明细
        function showdetail(id){
            //window.location.href="${ctx}/serverule/showdetail?ruleId="+id;
            var url = "${ctx}/serverule/showdetail?ruleId="+id;
            var title = "服务规则明细";
            var id = "服务规则明细";
            parent.openTab(url,title,id);
        }
        //新增方法
        function goadd(){
            window.location.href="${ctx}/serverule/goadd";
        }
        //修改方法
        function goupdate(id){
            window.location.href="${ctx}/serverule/goupdate?ruleId="+id;
        }
        function deleteRule(id){
        	$.jBox.confirm("确定要删除？","提示",function(value){
      			if(value=='ok'){
      				$.ajax({
      	        		url : "${ctx}/serverule/deleteRule",
      	        		type : "POST",
      	        		data :"ruleId="+id,// 你的formid
      	        		dataType : "json",
      	        		success : function(obj) {
      	        			if(obj.success==true){
      	        				$.jBox.success("删除成功!",'提示',{closed:function(){
									$("#searchForm").submit();
								}});
      	        			}else{
      	        				$.jBox.info("删除失败！");
      	        			}
      	        		},
      	        		error : function(xmlHttpRequest, textStatus, errorThrown) {
      	        			$.jBox.info("系统错误！请稍后再试！");
      	        		}
      	        	});
      			}
      		});
        	
        }
    </script>
    <style>
        table {
            max-width: 100%;
            background-color: transparent;
            border-collapse: collapse;
            border-spacing: 0;
        }
        .y-tb1{
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            border-left:1px solid #eee;
            border-right: 1px solid:#eee;
        }.y-tb1 td{
             border-top: 1px solid #eee;
             border-bottom: 1px solid #eee;
             border-left:1px solid #eee;
             border-right: 1px solid:#eee;
         }.y-tb1 th{
              border-top: 1px solid #eee;
              border-bottom: 1px solid #eee;
              border-left:1px solid #eee;
              border-right: 1px solid:#eee;
              font-weight:normal;
              color:#0000ff;
          }
        .mb20 {
            margin-bottom: 20px;
        }
        .z-tbl {
            width: 100%;
            text-align: center;
        }
        .z-tbl td {
            border-bottom: 1px dotted #ccc;
            padding: 10px 5px;
            line-height: 16px;
            color: #666;
            text-align: center;
        }.z-tbl th {
             border-bottom: 1px dotted #ccc;
             padding: 10px 5px;
             line-height: 16px;
             color: #666;
             text-align: center;
         }
        div{
            width: 95%;
        }
        .y-box {
            border: 1px solid #eee;
            border-top: 2px solid #00a2ca;
            margin-bottom: 20px;
        }

        h3{
            color:#000000;
            height: 46px;
            text-indent: 20px;
            font-size: 15px;
            font-family: \5FAE\8F6F\96C5\9ED1;
            font-weight: 500;
        }
        a.create-btn {
            position: absolute;
            top: 17px;
            right: 15%;
            padding: 10px 13px;
            line-height: 12px;
            color: #00a2ca;
            border: 1px solid #7ecbdf;
            background: #eafbfe;
            border-radius: 2px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
        }
        ul.ul1{
            display:inline;
            list-style:none;
            display:block;
        }
        li.li1{
            margin-bottom: 10px;
            margin-right: 30px;
            float:left;
            display:block;
        }
        span.gray-color{
            color: #999;
        }
    </style>
</head>
<body>
<div class="content sub-content">
    <div class="content-body content-sub-body" style="margin-left:3%;width: 95%;">
        <div class="y-box">
                <ul class="ul1">
                    <li class="li1">
                        <span class="gray-color"><h3 class="h3">服务规则</h3></span>
                    </li>
                </ul>
                <a href="javascript:void(0)" onclick="goadd()" class="create-btn">+创建服务规则</a>
            <form:form id="searchForm" modelAttribute="user" action="${ctx}/serverule/list/" method="post">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            </form:form>
            <table id="contentTable1" class="y-tb1 z-tbl mb20">
                <colgroup>
                    <col width="8%">
                    <col width="30%">
                    <col width="16%">
                    <col width="15%">
                    <col width="15%">
                    <col width="16%">
                </colgroup>
                <thead>
                <tr>
                    <th style="background: #fbfaf8;">序号</th>
                    <th style="background: #fbfaf8;">规则图片</th>
                    <th style="background: #fbfaf8;">规则名称</th>
                    <th style="background: #fbfaf8;">创建时间</th>
                    <th style="background: #fbfaf8;">创建人</th>
                    <th style="background: #fbfaf8;">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="user">
                    <tr>
                        <td>${user.num}</td>
                        <td>
                            <img class="showimg" style="height: 100px;width: 100px;padding-left: 10px"  src="${filePath}${user.url}" >
                        </td>
                        <td>${user.ruleName}</td>
                        <td>${user.createTime}</td>
                        <td>${user.createName}</td>
                        <td>
                            <a href="javascript:void(0)" onclick="showdetail('${user.ruleId}')">查看</a>|
                            <a href="javascript:void(0)" onclick="goupdate('${user.ruleId}')">编辑</a>|
                            <a href="javascript:void(0)" onclick="deleteRule('${user.ruleId}')">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="pagination">${page}</div>
        </div>
    </div>
</div>
</body>
</html>
