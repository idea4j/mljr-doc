#虚拟商品部分的sql
#m_virtual_commodity
ALTER TABLE m_virtual_commodity MODIFY `commodity_type` VARCHAR(2) DEFAULT NULL COMMENT '1、话费，2、流量，3、游戏，4、QQB' ,
 ADD `image_path` VARCHAR(255) DEFAULT NULL COMMENT '商品图片地址' ,
 MODIFY `province` VARCHAR(20) DEFAULT NULL COMMENT '省份或者游戏QQB产品ID' ,
 MODIFY `province_code` VARCHAR(50) DEFAULT NULL COMMENT '省份编码或者gameId' ,
 MODIFY `operator_company` VARCHAR(50) DEFAULT NULL COMMENT '100、移动，010、联通，001、电信' ,
 MODIFY `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
 MODIFY `update_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

#m_virtual_game
#虚拟游戏产品列表
CREATE TABLE `m_virtual_game` (
  `game_id` varchar(20) NOT NULL COMMENT '游戏ID',
  `game_name` varchar(50) DEFAULT NULL COMMENT '游戏名称',
  `game_key` varchar(10) DEFAULT NULL COMMENT '游戏名称的首字拼音大写',
  `company_id` varchar(20) DEFAULT NULL COMMENT '所属公司ID',
  `company_name` varchar(50) DEFAULT NULL COMMENT '所属公司名称',
  `hot` varchar(2) DEFAULT NULL COMMENT '是否热门 1：是    0：否',
  `virtual_type` varchar(2) DEFAULT NULL COMMENT '3、游戏  4、QQB',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

#m_virtual_game_area
#虚拟游戏区服
CREATE TABLE `m_virtual_game_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(20) DEFAULT NULL,
  `area_server` varchar(50) DEFAULT NULL COMMENT '游戏区服',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

#m_virtual_game_params
#虚拟游戏充值方式
CREATE TABLE `m_virtual_game_params` (
  `game_id` varchar(20) NOT NULL,
  `charge_way` varchar(10) DEFAULT NULL COMMENT '充值方式',
  `account_lable` varchar(50) DEFAULT NULL COMMENT '账号的标签',
  `account_text` varchar(10) DEFAULT NULL COMMENT '量词标签',
  `charge_type` varchar(50) DEFAULT NULL COMMENT '充值类型标签和值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

#m_virtual_update_plan
#虚拟商品同步计划
CREATE TABLE `m_virtual_update_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operator_company` varchar(50) DEFAULT NULL COMMENT '运营商名称',
  `provinces` varchar(255) DEFAULT NULL COMMENT '修改的区域汇总',
  `game_names` varchar(255) DEFAULT NULL COMMENT '游戏名',
  `commodity_type` varchar(5) DEFAULT NULL COMMENT '充值商品类型 1、话费，2、流量，3、游戏，4、QQB，1200、话费+流量，3400、游戏+QQB',
  `commodity_names` varchar(255) DEFAULT NULL COMMENT '需要修改充值商品名称汇总',
  `supply_factor` decimal(5,2) DEFAULT '1.00' COMMENT '协议折扣，默认不打折',
  `status` tinyint(5) NOT NULL DEFAULT '0' COMMENT '计划是否执行成功 0、未执行，1、已执行',
  `update_type` tinyint(5) NOT NULL DEFAULT '0' COMMENT '同步策略：1、同步列表，2、更新价格',
  `apply_time` datetime NOT NULL COMMENT '协议价生效时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

#t_dynamic_job
#虚拟商品计划任务
CREATE TABLE `t_dynamic_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `job_group` varchar(31) NOT NULL DEFAULT 'HR' COMMENT 'jobGroup',
  `job_name` varchar(63) NOT NULL COMMENT 'jobName',
  `name` varchar(31) NOT NULL COMMENT '中文名',
  `cron` varchar(31) DEFAULT NULL COMMENT 'CRON',
  `exec_time` datetime DEFAULT NULL COMMENT '期望运行时间',
  `job_class` varchar(255) NOT NULL COMMENT 'JobBiz实现类',
  `desp` varchar(127) DEFAULT NULL COMMENT '描述',
  `json_data` varchar(4095) DEFAULT NULL COMMENT 'json配置',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1:执行一次, 2:以cron为准',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0 已删除 1 有效',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '数据更新版本号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_job` (`job_group`,`job_name`) USING BTREE,
  KEY `idx_exec_time` (`exec_time`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4189 DEFAULT CHARSET=utf8 COMMENT='动态任务调度'
