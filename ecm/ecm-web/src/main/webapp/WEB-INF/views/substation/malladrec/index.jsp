<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>楼层推荐位</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/dialog.jsp"%>
<script type="text/javascript">

	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctx}/station/mallAdRec/index").submit();
    	return false;
    }
    function edit(id){
        var url = "${ctx}/mallAdRec/toEdit?id="+id;
        parent.openTab(url,"编辑推荐位","mar"+id);
    }
    function add(){
        var url = "${ctx}/mallAdRec/toEdit";
        parent.openTab(url,"新增推荐位","新增推荐位");
    }
    function delShow(mallAdRecId,obj) {
		var url=window.href='${ctx}/station/mallAdRec/delRecAttById?id='+mallAdRecId+'&pageNo='+$("#pageNo").val()+'&pageSize='+$("#pageSize").val();
		confirmx('确认要'+$(obj).text()+'吗？',url);
	}
    
  //根据选择的频道，查询楼层
	function findThemeFool(thiz){
		$.ajax({
      		url : "${ctx}/station/mallAdRec/mallReclist",
      		type : "POST",
      		data :"themeId="+thiz.value,// 你的formid
      		dataType : "json",
      		success : function(obj) {
      			$("#recId").empty();
      			$("#recId").append("<option value='' selected='selected'>请选择楼层</option>");
      			for(var i =0 ; i < obj.length ; i++){
      				$("#recId").append("<option value='"+obj[i].idDTO+"'>"+obj[i].titleDTO+"</option>");
      			}
      		},
      		error : function(xmlHttpRequest, textStatus, errorThrown) {
      			$.jBox.info("系统错误！请稍后再试！");
      		}
      	});
	}
  
	function unset(){ //重置
        $(':input','#searchForm')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('checked')
                .removeAttr('selected');
        $("#pageNo").val(1);
        $("#pageSize").val(10);
        $("#searchForm").submit();
    }
	
	//上架  下架
	function updateStatus(id,status){
		var url = "${ctx}/station/mallAdRec/publish";
         $.ajax({
             url : url,
             type : "post",
             dataType : "json",
             data:{
            	 id:id,
            	 status:status
             },
             success : function(data) {
                 if(data.success){
                     $.jBox.success("操作成功!",'提示',{closed:function(){
                         $("#searchForm").submit();
                     }});
                 }else{
                     $.jBox.info(data.msg);
                 }
             },
             error : function(xmlHttpRequest, textStatus, errorThrown) {
                 $.jBox.info("系统错误！请稍后再试！");
             }
         });
	}
</script>
</head>
<body>

	<form:form id="searchForm" modelAttribute="dto" action="${ctx}/station/mallAdRec/index/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<div class="row-fluid">
			<div class="span12">
				<label>&nbsp; &nbsp;&nbsp;&nbsp;频 &nbsp;&nbsp;&nbsp;&nbsp;道：</label>
                <form:select path="themeId" cssClass="input-medium" onchange="findThemeFool(this)">
                    <form:option value="" label="请选择频道"/>
                    <c:forEach items="${themes}" var="theme">
                    		<c:if test="${theme.status==1}">
                    			<option value="${theme.id}" ${theme.id==themeId?'selected':''}>${theme.themeName}</option>
                    		</c:if>
                    </c:forEach>
                </form:select>
				
				<label>楼层：</label>
				<form:select path="recId" cssClass="input-medium">
					<form:option value="" label="请选择楼层"></form:option>
					<form:options items="${recs}" itemLabel="titleDTO" itemValue="idDTO"/>
				</form:select>
				<label>类型：</label>
				<form:select path="recType" cssClass="input-medium">
					<form:option value="" label="请选择类型"></form:option>
					<form:option value="1" selected="selected" label="推荐商品"/>
					<%-- <form:option value="2" label="推荐活动"/>
	                <form:option value="3" label="顶部广告"/>
	                <form:option value="4" label="底部广告"/> --%>
				</form:select>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<label>推荐位主题：</label>
					<form:input path="title" htmlEscape="false" maxlength="50" cssClass="input-medium"/>
		            <label>状态：</label>
		            <form:select path="status" cssClass="input-medium">
		                <form:option value="" label="请选择状态"/>
		                <form:option value="1" label="展示中"/>
		                <form:option value="0" label="已下架"/>
		            </form:select>
            	</div>
			</div>
			<div class="row-fluid">
				<div sclass="span12">
						<label>&nbsp; &nbsp;&nbsp;&nbsp;时 &nbsp;&nbsp;&nbsp;&nbsp;间：</label>
						<form:select path="timeFlag" cssClass="input-medium">
							<form:option value="1" label="创建时间"/>
							<form:option value="2" label="发布时间"/>
			                <form:option value="3" label="下架时间"/>
			 			</form:select>
			 			<form:input id="d4311" path="startTime" class="Wdate input-medium" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>至
			 			<form:input path="endTime" class="Wdate input-medium" onfocus="WdatePicker({minDate:'\#F{\$dp.\$D(\\'d4311\\')}',dateFmt:'yyyy-MM-dd'})"/>
			            <input id="btnSubmit" class="btn btn-primary" type="submit" onclick="page(1,10)" value="查询"/>
			            <input id="btnSubmit" class="btn btn-primary" type="reset" value="重置"  onclick="unset();"/>
			            <a href="${ctx}/station/mallAdRec/toEdit" class="btn btn-primary" >新增</a>
	            </div>
            </div>
	</form:form>

	<tags:message content="${message}"/>
	<table id="contentTable" style="word-break:break-all" class="table table-striped table-bordered table-condensed" >
		<thead>
			<tr>
				<th style="width: 3%">序号</th>
				<th style="width: 5%">推荐位主题</th>
				<th style="width: 4%">类型</th>
				<th style="width: 10%">推荐位图片</th>
				<th style="width: 10%">指向链接</th>
				<th style="width: 5%">频道名称</th>
				<th style="width: 5%">楼层名称</th>
				<th style="width: 2%">顺序号</th>
				<th style="width: 5%">创建时间</th>
				<th style="width: 5%">发布时间</th>
                <th style="width: 5%">预下架时间</th>
                <th style="width: 5%">状态</th>
				<th style="width: 4%">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="mallAdRec" varStatus="s">
				<tr>
                    <td><c:out value="${s.count}" /></td>
					<td>${mallAdRec.title}</td>
					<td>
						<c:choose>
                            <c:when test="${mallAdRec.recType == 1}">
                                推荐商品
                            </c:when>
                            <c:when test="${mallAdRec.recType == 2}">
                                推荐活动
                            </c:when>
                            <c:when test="${mallAdRec.recType == 3}">
                                顶部广告
                            </c:when>
                            <c:when test="${mallAdRec.recType == 4}">
                                底部广告
                            </c:when>
						</c:choose>

					</td>
					<td><a href="${filePath}${mallAdRec.picSrc}" target="_blank">${filePath}${mallAdRec.picSrc}</a></td>
					<td><a href="${mallAdRec.url}" target="_blank">${mallAdRec.url}</a></td>
					<td>
						<c:forEach items="${themes}" var="theme">
							<c:if test="${theme.id == mallAdRec.themeId}">
								${theme.themeName}
							</c:if>
						</c:forEach>
					</td>
					<td>${mallAdRec.recName}</td>
					<td>${mallAdRec.sortNum}</td>
					<td>
						<fmt:formatDate value="${mallAdRec.created}" pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />
					</td>
					<td>
						<fmt:formatDate value="${mallAdRec.startTime}" pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />
					</td>
                    <td>
                        <fmt:formatDate value="${mallAdRec.endTime}" pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />
                    </td>
                    <td>
                        <c:if test="${ mallAdRec.status == 1 }">展示中</c:if>
                        <c:if test="${ mallAdRec.status == 0 }">已下架</c:if>
                    </td>
                    <td>
                        <c:if test="${ mallAdRec.status == 1 }">
                            <a href="javascript:void(0);" onclick="updateStatus(${mallAdRec.id},0)">下架</a>
                        </c:if>
                        <c:if test="${ mallAdRec.status == 0 or mallAdRec.status == null }">
                        	<a href="${ctx}/station/mallAdRec/toEdit?id=${mallAdRec.id}&pageNo=${page.pageNo}&pageSize=${page.pageSize}&recId=${dto.recId}&recType=${dto.recType}&title=${dto.title}&status=${dto.status}&timeFlag=${dto.timeFlag}&startTime=<fmt:formatDate value='${dto.startTime}' pattern='yyyy-MM-dd'/>&endTime=<fmt:formatDate value='${dto.endTime}' pattern='yyyy-MM-dd'/>">修改</a>
                            <a href="javascript:void(0);" onclick="updateStatus(${mallAdRec.id},1)">上架</a>
                        </c:if>
                        <c:if test="${ mallAdRec.status == 0 or mallAdRec.status == null }">
                            <%-- <a href="${ctx}/mallAdRec/delRecAttById?id=${mallAdRec.id}&pageNo=${page.pageNo}&pageSize=${page.pageSize}" >删除</a> --%>
                            <a href="javascript:void(0)" onclick="delShow(${mallAdRec.id},this)">删除</a>
                        </c:if>
                    </td>

				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>