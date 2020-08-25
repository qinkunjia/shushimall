package com.camelot.mall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.camelot.basecenter.dto.MallDocumentDTO;
import com.camelot.basecenter.service.MallDocumentService;
import com.camelot.mall.common.CommonService;
import com.camelot.openplatform.common.DataGrid;
import com.camelot.openplatform.common.ExecuteResult;
import com.camelot.openplatform.common.Pager;
import com.camelot.sellercenter.logo.dto.LogoDTO;
import com.camelot.sellercenter.logo.service.LogoExportService;
import com.camelot.sellercenter.malladvertise.dto.MallAdDTO;
import com.camelot.sellercenter.malladvertise.dto.MallAdQueryDTO;
import com.camelot.sellercenter.malladvertise.service.MallAdExportService;
import com.camelot.sellercenter.mallword.dto.MallWordDTO;
import com.camelot.sellercenter.mallword.service.MallWordExportService;
import com.camelot.usercenter.dto.UserDTO;
import com.camelot.usercenter.dto.UserMallResourceDTO;
import com.camelot.usercenter.service.UserExportService;
import com.camelot.usercenter.service.UserStorePermissionExportService;
import com.camelot.util.WebUtil;

/** 
 * <p>Description: [描述该类概要功能介绍]</p>
 * Created on 2015年3月16日
 * @author  <a href="mailto: guomaomao@camelotchina.com">Goma 郭茂茂</a>
 * @version 1.0 
 * Copyright (c) 2015 北京柯莱特科技有限公司 交付部 
 */
@Controller
public class CommonController {
	private Logger LOG = Logger.getLogger(this.getClass());
	@Resource
	private MallDocumentService mallDocumentService;
	@Resource
	private CommonService commonService;
	@Resource
	private UserStorePermissionExportService userStorePermissionExportService;
	@Resource
	private UserExportService userExportService;
	@Resource
	private LogoExportService logoService;
	@Resource
	private MallWordExportService mallWordService;
	@Resource
	private MallAdExportService mallAdvertisService;
	
	/**
	 * 
	 * <p>Discription:页尾查询</p>
	 * Created on 2015年3月11日
	 * @param model
	 * @return
	 * @author:[Goma 郭茂茂]
	 */
	@RequestMapping("/footer")
	public String footer(Model model){
		MallDocumentDTO dto = new MallDocumentDTO();
		dto.setMallStatus(2);
		dto.setMallType(2);
		@SuppressWarnings("rawtypes")
		Pager pager = new Pager();
		pager.setPage(1);
		pager.setRows(100);
		pager.setSort("mallClassifyId");
		pager.setOrder("asc");
		DataGrid<MallDocumentDTO> dg = this.mallDocumentService.queryMallDocumentList(dto, pager);
		model.addAttribute("documents", dg.getRows());
		LOG.debug("Footer Documents: " + JSON.toJSONString(dg.getRows()));
		dto.setMallType(7);
		DataGrid<MallDocumentDTO> dgg = this.mallDocumentService.queryMallDocumentList(dto, pager);
		model.addAttribute("footDocs", dgg.getRows());
		return "/common/footer_doc";
	}
	/**
	 * 
	 * <p>Discription:[方法功能中文描述：卖家中心左侧导航]</p>
	 * Created on 2016年1月28日
	 * @param model
	 * @param request
	 * @return
	 * @author:[马桂雷]
	 */
	@RequestMapping("/leftSeller")
	public String leftSeller(Model model, HttpServletRequest request){
		buildMenuByModuleType(model, request, com.camelot.util.Constants.MODULE_TYPE_SELLER);
		return "/common/left_seller";
	}
	/**
	 * 
	 * <p>Discription:[方法功能中文描述：查询对应账号菜单]</p>
	 * Created on 2016年1月28日
	 * @param model
	 * @param request
	 * @param moduleType
	 * @author:[马桂雷]
	 */
	private void buildMenuByModuleType(Model model, HttpServletRequest request, Integer moduleType) {
		long uid = WebUtil.getInstance().getUserId(request);
		UserDTO user = userExportService.queryUserById(uid);
		ExecuteResult<List<UserMallResourceDTO>> reslist = new ExecuteResult<List<UserMallResourceDTO>>();
		if(user.getParentId()==null || 1L==user.getParentId()){//父账号：查询所有卖家菜单数据
			reslist = userStorePermissionExportService.queryParentResourceList(moduleType, moduleType);
		}else{//子账号：查询对应的菜单数据
			reslist = userStorePermissionExportService.queryUserMallResourceById(uid, moduleType);
		}
		model.addAttribute("reslist", reslist.getResult());
	}

	/**
	 * 
	 * <p>Discription:[方法功能中文描述：买家中心左侧导航]</p>
	 * Created on 2015年3月14日
	 * @param model
	 * @param request
	 * @return
	 * @author:[周乐]
	 */
	@RequestMapping("/leftBuyer")
	public String leftBuyer(Model model, HttpServletRequest request){
		buildMenuByModuleType(model, request, com.camelot.util.Constants.MODULE_TYPE_BUYER);
		return "/common/left_buyer";
	}
	/**
	 * 
	 * <p>Discription:[方法功能中文描述]</p>
	 * Created on 2016年1月28日
	 * @param model
	 * @return
	 * @author:[周乐]
	 */
	
	@RequestMapping("/allCategory")
	public String allCategory(Model model){
		JSONArray categoryes = this.commonService.findCategory();
		model.addAttribute("categoryes", categoryes);
		LOG.debug("平台所有类目："+categoryes.toJSONString());
		return "/common/left_category";
	}

	/**
	 * 
	 * <p>Discription:商城LOGO查询</p>
	 * Created on 2015年4月28日
	 * @param model
	 * @return
	 * @author:[Goma 郭茂茂]
	 */
	@RequestMapping("/logo")
	@ResponseBody
	public LogoDTO mallLogo(){
		ExecuteResult<LogoDTO> er = this.logoService.getMallLogo();
		return er.getResult();
	}
	/**
	 * 
	 * <p>Discription:[方法功能中文描述]</p>
	 * Created on 2016年1月28日
	 * @return
	 * @author:[周乐]
	 */
	
	@RequestMapping("/mallWord")
	@ResponseBody
	public List<MallWordDTO> mallWord(){
		MallWordDTO dto = new MallWordDTO();
		@SuppressWarnings("rawtypes")
		Pager page = new Pager();
		page.setRows(15);
		page.setPage(1);
		DataGrid<MallWordDTO> dg = this.mallWordService.datagrid(dto, page);
		return dg.getRows();
	}
	/**
	 * 
	 * <p>Discription:[方法功能中文描述]</p>
	 * Created on 2016年1月28日
	 * @param p
	 * @param model
	 * @return
	 * @author:[周乐]
	 */
	@RequestMapping("/guessLove")
	public String guessLove(Integer p,Model model){
		if( p == null )
			p = 0;
		Pager<MallAdDTO> page = new Pager<MallAdDTO>();
		page.setRows(6);
		page.setPage(p);
		
		MallAdQueryDTO mallAdQueryDTO = new MallAdQueryDTO();
		mallAdQueryDTO.setStatus(1);
		mallAdQueryDTO.setAdType(5);
		
		DataGrid<MallAdDTO> advertises = this.mallAdvertisService.queryMallAdList(page, mallAdQueryDTO);
		
		page.setRecords(advertises.getRows());
		page.setTotalCount(advertises.getTotal().intValue());
		
		model.addAttribute("guessLovePage", page);
		
		return "/home/guess_love";
	}
	
	/**
	 * 
	 * <p>Discription:[方法功能中文描述]</p>
	 * Created on 2016年1月28日
	 * @param model
	 * @return
	 * @author:[周乐]
	 */
	@RequestMapping("/recommend")
	public String recommend(Model model){
		Pager<MallAdDTO> page = new Pager<MallAdDTO>();
		page.setRows(5);
		page.setPage(1);
		
		MallAdQueryDTO mallAdQueryDTO = new MallAdQueryDTO();
		mallAdQueryDTO.setStatus(1);
		mallAdQueryDTO.setAdType(5);
		DataGrid<MallAdDTO> advertises = this.mallAdvertisService.queryMallAdList(page, mallAdQueryDTO);
		model.addAttribute("jcProducts", advertises.getRows());

		MallAdQueryDTO adQuery = new MallAdQueryDTO();
		adQuery.setStatus(1);
		adQuery.setAdType(1);
		DataGrid<MallAdDTO> dg = this.mallAdvertisService.queryMallAdList(page, adQuery);
		model.addAttribute("hotProducts", dg.getRows());
		return "/common/recommend";
	}
}
