package com.camelot.shop.domain;
import java.io.Serializable;

/**
 * 
 * <p>Description: [描述该类概要功能介绍:店铺描述domain类]</p>
 * Created on 2015年2月3日
 * @author  <a href="mailto: zhangzhiqiang34@camelotchina.com">chenx</a>
 * @version 1.0 
 * Copyright (c) 2015 北京柯莱特科技有限公司 交付部
 */
public class ShopEvaluation  implements Serializable{
	
	private static final long serialVersionUID = -5236308770493344643L;
	private java.lang.Long id;//  id
	private java.lang.Long userId;//  评价人id
	private java.lang.Long userShopId;//  评价人店铺id
	private java.lang.Long byShopId;//  被评价店铺ID
	private String resource = "2";//1:默认回复 2:手动回复
	private String orderId;  //订单id
	private java.lang.Integer shopDescriptionScope;//  描述相符评分
	private java.lang.Integer shopServiceScope;//  服务态度评分
	private java.lang.Integer shopArrivalScope;//  到货速度评分
	private java.util.Date createTime;//  创建时间
	private java.util.Date modifyTime;//  编辑时间
	
	public java.lang.Long getId() {
		return id;
	}
	public void setId(java.lang.Long id) {
		this.id = id;
	}
	public java.lang.Long getUserId() {
		return userId;
	}
	public void setUserId(java.lang.Long userId) {
		this.userId = userId;
	}
	public java.lang.Long getUserShopId() {
		return userShopId;
	}
	public void setUserShopId(java.lang.Long userShopId) {
		this.userShopId = userShopId;
	}
	public java.lang.Long getByShopId() {
		return byShopId;
	}
	public void setByShopId(java.lang.Long byShopId) {
		this.byShopId = byShopId;
	}
	public java.lang.Integer getShopDescriptionScope() {
		return shopDescriptionScope;
	}
	public void setShopDescriptionScope(java.lang.Integer shopDescriptionScope) {
		this.shopDescriptionScope = shopDescriptionScope;
	}
	public java.lang.Integer getShopServiceScope() {
		return shopServiceScope;
	}
	public void setShopServiceScope(java.lang.Integer shopServiceScope) {
		this.shopServiceScope = shopServiceScope;
	}
	public java.lang.Integer getShopArrivalScope() {
		return shopArrivalScope;
	}
	public void setShopArrivalScope(java.lang.Integer shopArrivalScope) {
		this.shopArrivalScope = shopArrivalScope;
	}
	public java.util.Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
	}
	public java.util.Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(java.util.Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getResource() {
		return resource;
	}
	public void setResource(String resource) {
		this.resource = resource;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
}

