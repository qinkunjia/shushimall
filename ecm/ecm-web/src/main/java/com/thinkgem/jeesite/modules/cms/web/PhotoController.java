/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *//*


package com.thinkgem.jeesite.modules.cms.web;

import com.camelot.cmscenter.dto.CmsImageDto;
import com.camelot.cmscenter.service.CmsImageService;
import com.camelot.openplatform.common.DataGrid;
import com.camelot.openplatform.common.ExecuteResult;
import com.camelot.openplatform.common.Pager;
import com.camelot.openplatform.common.enmu.BasicEnum;
import com.camelot.openplatform.util.SysProperties;
import com.camelot.sellercenter.mallBanner.dto.MallBannerDTO;
import com.camelot.sellercenter.mallBanner.dto.MallBannerInDTO;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.FreeMarkers;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.ArticleImage;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.service.*;
import com.thinkgem.jeesite.modules.cms.utils.TplUtils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;

*/
/**
 * ImageController图集Controller
 * @author mengbo
 * @version 2016-2-16
 *//*


@Controller
@RequestMapping(value = "admin/cms/photoMange")
public class PhotoController extends BaseController {
	@Resource
	private CmsImageService cmsImageService;
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmsImageDto cmsImageDto,HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<CmsImageDto> page = new Page<CmsImageDto>(request, response);

		Pager pager = new Pager();
		pager.setPage(page.getPageNo());
		pager.setRows(page.getPageSize());
		pager.setPageOffset((page.getPageNo() - 1) * page.getPageSize() + 1);
//		pager.setSort("");
//		pager.setOrder("desc");
		DataGrid<CmsImageDto> pageGrid = cmsImageService.queryCmsImageList(pager, cmsImageDto);

		page.setCount(pageGrid.getTotal());
		page.setList(pageGrid.getRows());
		model.addAttribute("page", page);
		return "modules/cms/photoList";
	}
	@RequestMapping("form")
	public String form(CmsImageDto cmsImageDto, Model model) {
		CmsImageDto cmsImageDtoPage = cmsImageService.getCmsImgById(cmsImageDto.getId());
		model.addAttribute("cmsImageDtoPage",cmsImageDtoPage);
		return "modules/cms/photoForm";
	}

	@RequestMapping("save")
	public String save(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse, Model model) {
		String imgname=httpServletRequest.getParameter("cmsImageDto.imgname");
		String remark=httpServletRequest.getParameter("cmsImageDto.remark");
		String bannerUrl=httpServletRequest.getParameter("bannerUrl");
		bannerUrl = bannerUrl.replaceAll(SysProperties.getProperty("ngIp"), "");
		String id=httpServletRequest.getParameter("cmsImageDto.id");
		CmsImageDto cmsImageDto=new CmsImageDto();
		cmsImageDto.setImgname(imgname);
		cmsImageDto.setPath(bannerUrl);
		cmsImageDto.setRemark(remark);
		cmsImageDto.setId(id);
		cmsImageDto.setCreatedate(new Date());
		cmsImageService.modifyCmsImg(cmsImageDto);
		System.out.print(SysProperties.getAdminPath());
		return "redirect:" + SysProperties.getAdminPath() + "/cms/photoMange/list";
	}

}*/
