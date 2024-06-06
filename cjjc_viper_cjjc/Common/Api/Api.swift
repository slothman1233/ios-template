//
//  HlSingleConfigs.swift
//  YHL
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import Foundation

enum BaseApi: String {
#if DEBUG


    //生产
    case baseUrl = "http://139.159.187.53/yd-api-member/"
#else
    
    //生产
    case baseUrl = "http://139.159.187.53/yd-api-member/"

#endif
    
}

struct Api {
    static let baseUrl = BaseApi.baseUrl.rawValue
    // MARK: -  注册 登录
    /* *********** 注册 *********** */
    static let register = baseUrl + "auth/register"
    
    /* *********** 登录 *********** */
    static let login = baseUrl + "auth/login"
    
    /* *********** 验证码登录 *********** */
    static let smsLogin = baseUrl + "auth/smsLogin"
    
    /* *********** 验证码发送接口 *********** */
    static let smsCodeSend = baseUrl + "auth/smsCodeSend"
    
    /* *********** 修改登录密码接口 *********** */
    static let resetLoginPwd = baseUrl + "auth/resetLoginPwd"
    
    /* *********** 修改支付密码接口 *********** */
    static let modifyPayPwd = baseUrl + "auth/modifyPayPwd"

    // MARK: -  首页
    /* *********** 平台公告列表 *********** */
    static let getSysPlatformNotice = baseUrl + "sysPlatformNotice/getSysPlatformNotice"
    
    /* *********** 消息列表 *********** */
    static let memberMessage_listPage = baseUrl + "memberMessage/listPage"
    
    /* *********** 未读取数量 *********** */
    static let unReadCount = baseUrl + "memberMessage/unReadCount"
    
    /* *********** 首页列表 *********** */
    static let getHomeList = baseUrl + "mall/getHomeList"
    
    /* *********** 更新 *********** */
    static let getSysVersion = baseUrl + "sysConfig/getSysVersion"
    
    /* *********** 第三方任务入口列表 *********** */
    static let sysTaskTypeList = baseUrl + "sysConfig/sysTaskTypeList"
    
    // MARK: -  获取排行信息
    /* *********** 获取排行信息 *********** */
    static let rank_list = baseUrl + "statistic/rank/list"
    
    // MARK: -  活动
    /* *********** 获取活动详情 *********** */
    static let active_details = baseUrl + "active/details"
    
    /* *********** 查询任务完成信息 *********** */
    static let active_task_info = baseUrl + "active/task/info"
    
    
    // MARK: -  新闻列表
    static let getNewsList = baseUrl + "news/getNewsList"
    
    // MARK: -  认证
    /// 提交
    static let addMemberVerify = baseUrl + "memberVerify/addMemberVerify"
    
    /// 获取认证情况
    static let getMemberVerify = baseUrl + "memberVerify/getMemberVerify"
    
    // MARK: -  资产
    /// 获取一些列交易记录
    static let listPage = baseUrl + "account/listPage"
    /// 获取资产
    static let getAccountAsset = baseUrl + "account/getAccountAsset"
    /// 获取类型
    static let getTradeType = baseUrl + "account/getTradeType"
    
    // MARK: -  银行卡
    /// 获取一些列交易记录
    static let addBank = baseUrl + "bank/addBank"
    /// 获取资产
    static let deleteBank = baseUrl + "bank/deleteBank"
    /// 获取类型
    static let getBankList = baseUrl + "bank/getBankList"
    
    // MARK: -  提现
    /// 获取一些列交易记录
    static let getConfig = baseUrl + "withdraw/getConfig"
    /// 获取资产
    static let withdrawRecord = baseUrl + "withdraw/record"
    /// 获取类型
    static let withdrawApply = baseUrl + "withdraw/withdrawApply"
    
    // MARK: -  充值
    /// 获取充值类型
    static let getPayMethod = baseUrl + "recharge/getPayMethod"
    /// 提交充值
    static let rechargeApply = baseUrl + "recharge/rechargeApply"
    /// 充值记录
    static let chargeRecord = baseUrl + "recharge/record"
    
    // MARK: -  个人中心
    /* *********** 修改用户信息 *********** */
    static let updateMemberDetail = baseUrl + "member/updateMemberDetail"
    
    /* *********** 用户详情 *********** */
    static let getMemberDetail = baseUrl + "member/getMemberDetail"
    
    /* *********** 修改手机号码 *********** */
    static let updateMemberPhone = baseUrl + "member/updateMemberPhone"
    
    /* *********** 文件上传*********** */
    static let upload = baseUrl + "fileUpload/upload"
    
    /* *********** 批量文件上传*********** */
    static let uploads = baseUrl + "fileUpload/uploads"
    
    /* *********** 我的团队-统计*********** */
    static let getTeamCount = baseUrl + "member/getTeamCount"
    
    /* *********** 我的团队-直推列表 *********** */
    static let getDirectPushList = baseUrl + "member/getDirectPushList"
    
    /* *********** 我的团队-佣金 *********** */
    static let commissionList = baseUrl + "member/commissionList"
    
    /* *********** 我的团队-佣金查看个人 *********** */
    static let commissionListByMember = baseUrl + "member/commissionListByMember"
    
    /* *********** 联系客服 *********** */
    static let getSysCustomerService = baseUrl + "sysCustomerService/getSysCustomerService"
    
    /* *********** 系统反馈 *********** */
    static let addFeedback = baseUrl + "sysFeedback/addFeedback"
    
    /* *********** 签约服务商********** */
    static let fws_contract = baseUrl + "task/fws/contract"
    
    /* *********** 服务商权益详情 *********** */
    static let fws_details = baseUrl + "task/fws/rights/details"
    
    // MARK: -  Other
    /* *********** 获取轮播图 *********** */
    static let getRotationUrl = baseUrl + "sysUrlConfig/getRotationUrl"
    
    // MARK: -  开关配置
    /* *********** 活动开关 *********** */
    static let sysConfig_isOpen = baseUrl + "sysConfig/isOpen"
    
    /* *********** 配置 *********** */
    static let getSysConfigList = baseUrl + "sysConfig/getSysConfigList"
    
    /* *********** 协议 *********** */
    static let sysAgreement_list = baseUrl + "sysAgreement/list"
}
