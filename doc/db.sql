create database apidb2 default character set utf8mb4;

create table ad_account (
  id int auto_increment primary key,
  account_key varchar(64),
  account_name varchar(32),
  api_key varchar(255),
  created timestamp,
  unique key account_key(account_key)
) default character set=utf8mb4 collate utf8mb4_general_ci;

insert into ad_account (id, account_key, account_name, api_key, created) values
  (1, 'talkingdata', 'TalkingData', '', now());
insert into ad_account (id, account_key, account_name, api_key, created) values
  (2, 'mat', 'TalkingData', '', now());

drop table ad_app;
create table ad_app (
  id int auto_increment primary key,
  app_key varchar(64),
  app_name varchar(32),
  src_timezone varchar(32),
  dst_timezone varchar(32),
  created timestamp,
  unique key account_key(app_key)
) default character set=utf8mb4 collate utf8mb4_general_ci;

insert into ad_app (app_key, app_name, src_timezone, dst_timezone, created) values
  ('battleship2cn', '战舰帝国2-IOS-CN', 'UTC', 'Asia/Shanghai', now());
insert into ad_app (app_key, app_name, src_timezone, dst_timezone, created) values
  ('battleship2cn-android', '战舰帝国2-Android-CN', 'UTC', 'Asia/Shanghai', now());

drop table ad_param_map;
create table ad_param_map (
  id int auto_increment primary key,
  source varchar(24) default null,
  param_name varchar(32),
  std_name varchar(32),
  unique key param_key (source, std_name)
) default character set=utf8mb4 collate utf8mb4_general_ci;

replace into ad_param_map (source, param_name, std_name)
values
  (null, 'stat_id', 'stat_id'),
  (null, 'app_key', 'app_key'),
  (null, 'os_version', 'os_version'),
  (null, 'device_id', 'device_id'),
  (null, 'device_type', 'device_type'),
  (null, 'device_brand', 'device_brand'),
  (null, 'device_carrier', 'device_carrier'),
  (null, 'device_model', 'device_model'),
  (null, 'lang', 'lang'),
  (null, 'plat_id', 'plat_id'),
  (null, 'user_agent', 'user_agent'),
  (null, 'publisher_id', 'publisher_id'),
  (null, 'publisher_name', 'publisher_name'),
  (null, 'click_ip', 'click_ip'),
  (null, 'click_time', 'click_time'),
  (null, 'bundle_id', 'bundle_id'),
  (null, 'ip', 'ip'),
  (null, 'created', 'created'),
  (null, 'agency_name', 'agency_name'),
  (null, 'site_id', 'site_id'),
  (null, 'site_name', 'site_name'),
  (null, 'match_type', 'match_type'),
  (null, 'is_view_through', 'is_view_through'),
  (null, 'is_retarget', 'is_retarget'),
  (null, 'campaign_id', 'campaign_id'),
  (null, 'campaign_name', 'campaign_name'),
  (null, 'ad_url', 'ad_url'),
  (null, 'ad_name', 'ad_name'),
  (null, 'region_name', 'region_name'),
  (null, 'country_code', 'country_code'),
  (null, 'currency_code', 'currency_code'),
  (null, 'existing_user', 'existing_user'),
  (null, 'imp_time', 'imp_time'),
  (null, 'stat_click_id', 'stat_click_id'),
  (null, 'stat_impression_id', 'stat_impression_id'),
  (null, 'payout', 'payout'),
  (null, 'referral_source', 'referral_source'),
  (null, 'referral_url', 'referral_url'),
  (null, 'revenue', 'revenue'),
  (null, 'revenue_usd', 'revenue_usd'),
  (null, 'status', 'status'),
  (null, 'status_code', 'status_code'),
  (null, 'tracking_id', 'tracking_id'),
  (null, 'ios_ifa', 'ios_ifa'),
  (null, 'ios_ifv', 'ios_ifv'),
  (null, 'google_aid', 'google_aid'),
  (null, 'pub_camp_id', 'pub_camp_id'),
  (null, 'pub_camp_name', 'pub_camp_name'),
  (null, 'pub_camp_ref', 'pub_camp_ref'),
  (null, 'pub_adset', 'pub_adset'),
  (null, 'pub_ad', 'pub_ad'),
  (null, 'pub_keyword', 'pub_keyword'),
  (null, 'pub_place', 'pub_place'),
  (null, 'pub_sub_id', 'pub_sub_id'),
  (null, 'pub_sub_name', 'pub_sub_name'),
  (null, 'adv_camp_id', 'adv_camp_id'),
  (null, 'adv_camp_name', 'adv_camp_name'),
  (null, 'adv_camp_ref', 'adv_camp_ref'),
  (null, 'adv_adset', 'adv_adset'),
  (null, 'adv_ad', 'adv_ad'),
  (null, 'adv_keyword', 'adv_keyword'),
  (null, 'adv_place', 'adv_place'),
  (null, 'adv_sub_id', 'adv_sub_id'),
  (null, 'adv_sub_name', 'adv_sub_name'),
  (null, 'sdk', 'sdk'),
  (null, 'sdk_version', 'sdk_version'),
  (null, 'game_user_id', 'game_user_id'),
  (null, 'os_jailbroke', 'os_jailbroke'),
  (null, 'pub_ref_id', 'pub_pref_id'),
  (null, 'pub_sub1', 'pub_sub1'),
  (null, 'pub_sub2', 'pub_sub2'),
  (null, 'pub_sub3', 'pub_sub3'),
  (null, 'cost_model', 'cost_model'),
  (null, 'cost', 'cost'),
  (null, 'ip_from', 'ip_from'),
  (null, 'ip_to', 'ip_to'),
  (null, 'city_code', 'city_code'),
  (null, 'proxy_type', 'proxy_type'),
  (null, 'install_time', 'install_time'),
  (null, 'sku_id', 'sku_id'),
  (null, 'order_id', 'order_id'),
  (null, 'conversion_timestamp', 'conversion_timestamp');

drop table ad_register;
create table ad_register (
  id bigint auto_increment primary key,
  account_key varchar(50) DEFAULT NULL,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  publisher_id varchar(50) DEFAULT NULL,
  publisher_name varchar(50) DEFAULT NULL,
  campaign_id varchar(50) DEFAULT NULL,
  campaign_name varchar(100) DEFAULT NULL,
  is_paid bool DEFAULT False,
  total_paid double DEFAULT 0,
  created datetime DEFAULT NULL,
  last_date datetime DEFAULT NULL,
  region_name varchar(50) DEFAULT NULL,
  country_code varchar(20) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  unique key id (account_key, source, stat_id, app_key),
  key ios_ifa (ios_ifa, google_aid),
  key created (created)
) default character set=utf8mb4 collate utf8mb4_general_ci;

drop table ad_gameuser;
create table ad_gameuser (
  id bigint auto_increment primary key,
  account_key varchar(50) DEFAULT NULL,
  source varchar(50) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  device_id varchar(100) DEFAULT NULL,
  game_user_id varchar(100) DEFAULT NULL,
  created datetime DEFAULT NULL,
  revenue double,
  revenue_usd double,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  unique key id (account_key, source, app_key, stat_id, game_user_id, site_name),
  key device_id (device_id),
  key game_user_id (game_user_id),
  key stat_id (stat_id)
) default character set=utf8mb4 collate utf8mb4_general_ci;

drop table ad_postback;
create table ad_postback (
  id bigint auto_increment primary key,
  action varchar(50) DEFAULT 'install',
  account_key varchar(50) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  created datetime,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  plat_id varchar(100) DEFAULT NULL,
  publisher_id varchar(100) DEFAULT NULL,
  publisher_name varchar(100) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  tracking_id varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  ip_from int(10) unsigned zerofill,
  ip_to  int(10) unsigned zerofill,
  status varchar(50) DEFAULT NULL,
  status_code varchar(20) DEFAULT NULL,
  postback_code int(11) DEFAULT 0,
  postback_desc varchar(100),
  key id (stat_id),
  key created (created),
  key aid ( ios_ifa, google_aid )
) default character set=utf8mb4 collate utf8mb4_general_ci;

alter table ad_postback add column status varchar(50) default null;
alter table ad_postback add column status_code varchar(20) default null;

drop table ad_install;
create table ad_install (
  id bigint auto_increment primary key,
  action varchar(50) DEFAULT 'install',
  account_key varchar(50) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  created datetime,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  os_version varchar(20) DEFAULT NULL,
  device_id varchar(100) DEFAULT NULL,
  device_type varchar(100) DEFAULT NULL,
  device_brand  varchar(100) DEFAULT NULL,
  device_carrier  varchar(100) DEFAULT NULL,
  device_model  varchar(100) DEFAULT NULL,
  lang  varchar(20) DEFAULT NULL,
  plat_id varchar(100) DEFAULT NULL,
  user_agent varchar(200) DEFAULT NULL,
  publisher_id varchar(100) DEFAULT NULL,
  publisher_name varchar(100) DEFAULT NULL,
  click_ip varchar(50) DEFAULT NULL,
  click_time datetime,
  bundle_id varchar(100) DEFAULT NULL,
  agency_name varchar(50) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  match_type varchar(50) DEFAULT NULL,
  campaign_id varchar(100) DEFAULT NULL,
  campaign_name varchar(100) DEFAULT NULL,
  ad_url varchar(200) DEFAULT NULL,
  ad_name varchar(250) DEFAULT NULL,
  region_name varchar(50) DEFAULT NULL,
  country_code varchar(20) DEFAULT NULL,
  currency_code varchar(10) DEFAULT NULL,
  existing_user boolean,
  imp_time datetime,
  stat_click_id varchar(200) DEFAULT NULL,
  stat_impression_id varchar(200) DEFAULT NULL,
  payout double,
  referral_source text DEFAULT NULL,
  referral_url text DEFAULT NULL,
  revenue double,
  revenue_usd double,
  status varchar(50) DEFAULT NULL,
  status_code varchar(20) DEFAULT NULL,
  tracking_id varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  ios_ifv varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  pub_camp_id varchar(50) DEFAULT NULL,
  pub_camp_name varchar(250) DEFAULT NULL,
  pub_camp_ref varchar(250) DEFAULT NULL,
  pub_adset varchar(250) DEFAULT NULL,
  pub_ad varchar(250) DEFAULT NULL,
  pub_keyword varchar(250) DEFAULT NULL,
  pub_place varchar(250) DEFAULT NULL,
  pub_sub_id varchar(250) DEFAULT NULL,
  pub_sub_name varchar(250) DEFAULT NULL,
  adv_camp_id varchar(250) DEFAULT NULL,
  adv_camp_name varchar(250) DEFAULT NULL,
  adv_camp_ref varchar(250) DEFAULT NULL,
  adv_adset varchar(250) DEFAULT NULL,
  adv_ad varchar(250) DEFAULT NULL,
  adv_keyword varchar(250) DEFAULT NULL,
  adv_place varchar(250) DEFAULT NULL,
  adv_sub_id varchar(250) DEFAULT NULL,
  adv_sub_name varchar(250) DEFAULT NULL,
  sdk varchar(20) DEFAULT NULL,
  sdk_version varchar(20) DEFAULT NULL,
  game_user_id varchar(200) DEFAULT NULL,
  os_jailbroke boolean,
  pub_pref_id varchar(250) DEFAULT NULL,
  pub_sub1 varchar(250) DEFAULT NULL,
  pub_sub2 varchar(250) DEFAULT NULL,
  pub_sub3 varchar(250) DEFAULT NULL,
  pub_sub4 varchar(250) DEFAULT NULL,
  pub_sub5 varchar(250) DEFAULT NULL,
  cost_model varchar(50) DEFAULT NULL,
  order_id varchar(200) DEFAULT NULL,
  cost double,
  ip_from int(10) unsigned zerofill,
  ip_to  int(10) unsigned zerofill,
  city_code varchar(20) DEFAULT NULL,
  is_proxy int DEFAULT 0,
  proxy_type varchar(20) DEFAULT NULL,
  eval_prop float DEFAULT 0,
  key id (stat_id),
  key install_time (created),
  key aid ( ios_ifa, google_aid )
) default character set=utf8mb4 collate utf8mb4_general_ci;

# alter table ad_install add column eval_prop float default 0;
# alter table ad_install add column postback_code int(11) default 0;
# alter table ad_install add column postback_desc varchar(100) default null;

drop table ad_purchase;
create table ad_purchase(
  id bigint auto_increment primary key,
  action varchar(50) DEFAULT 'install',
  account_key varchar(50) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  created datetime,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  os_version varchar(20) DEFAULT NULL,
  device_id varchar(100) DEFAULT NULL,
  device_type varchar(100) DEFAULT NULL,
  device_brand  varchar(100) DEFAULT NULL,
  device_carrier  varchar(100) DEFAULT NULL,
  device_model  varchar(100) DEFAULT NULL,
  lang  varchar(20) DEFAULT NULL,
  plat_id varchar(100) DEFAULT NULL,
  user_agent varchar(200) DEFAULT NULL,
  publisher_id varchar(100) DEFAULT NULL,
  publisher_name varchar(100) DEFAULT NULL,
  click_ip varchar(50) DEFAULT NULL,
  click_time datetime,
  bundle_id varchar(100) DEFAULT NULL,
  agency_name varchar(50) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  match_type varchar(50) DEFAULT NULL,
  campaign_id varchar(100) DEFAULT NULL,
  campaign_name varchar(100) DEFAULT NULL,
  ad_url varchar(200) DEFAULT NULL,
  ad_name varchar(250) DEFAULT NULL,
  region_name varchar(50) DEFAULT NULL,
  country_code varchar(20) DEFAULT NULL,
  currency_code varchar(10) DEFAULT NULL,
  existing_user boolean,
  imp_time datetime,
  stat_click_id varchar(200) DEFAULT NULL,
  stat_impression_id varchar(200) DEFAULT NULL,
  payout double,
  referral_source text DEFAULT NULL,
  referral_url text DEFAULT NULL,
  revenue double,
  revenue_usd double,
  status varchar(50) DEFAULT NULL,
  status_code varchar(20) DEFAULT NULL,
  tracking_id varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  ios_ifv varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  pub_camp_id varchar(50) DEFAULT NULL,
  pub_camp_name varchar(250) DEFAULT NULL,
  pub_camp_ref varchar(250) DEFAULT NULL,
  pub_adset varchar(250) DEFAULT NULL,
  pub_ad varchar(250) DEFAULT NULL,
  pub_keyword varchar(250) DEFAULT NULL,
  pub_place varchar(250) DEFAULT NULL,
  pub_sub_id varchar(250) DEFAULT NULL,
  pub_sub_name varchar(250) DEFAULT NULL,
  adv_camp_id varchar(250) DEFAULT NULL,
  adv_camp_name varchar(250) DEFAULT NULL,
  adv_camp_ref varchar(250) DEFAULT NULL,
  adv_adset varchar(250) DEFAULT NULL,
  adv_ad varchar(250) DEFAULT NULL,
  adv_keyword varchar(250) DEFAULT NULL,
  adv_place varchar(250) DEFAULT NULL,
  adv_sub_id varchar(250) DEFAULT NULL,
  adv_sub_name varchar(250) DEFAULT NULL,
  sdk varchar(20) DEFAULT NULL,
  sdk_version varchar(20) DEFAULT NULL,
  game_user_id varchar(200) DEFAULT NULL,
  os_jailbroke boolean,
  pub_pref_id varchar(250) DEFAULT NULL,
  pub_sub1 varchar(250) DEFAULT NULL,
  pub_sub2 varchar(250) DEFAULT NULL,
  pub_sub3 varchar(250) DEFAULT NULL,
  pub_sub4 varchar(250) DEFAULT NULL,
  pub_sub5 varchar(250) DEFAULT NULL,
  cost_model varchar(50) DEFAULT NULL,
  order_id varchar(200) DEFAULT NULL,
  cost double,
  ip_from int(10) unsigned zerofill,
  ip_to  int(10) unsigned zerofill,
  city_code varchar(20) DEFAULT NULL,
  is_proxy int default 0,
  proxy_type varchar(20) DEFAULT NULL,
  eval_prop float DEFAULT 0,
  key id (stat_id),
  key install_time (created),
  key aid ( ios_ifa, google_aid )
) default character set=utf8mb4 collate utf8mb4_general_ci;

drop table ad_click;
create table ad_click (
  id bigint auto_increment primary key,
  action varchar(50) DEFAULT 'install',
  account_key varchar(50) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  created datetime,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  os_version varchar(20) DEFAULT NULL,
  device_id varchar(100) DEFAULT NULL,
  device_type varchar(100) DEFAULT NULL,
  device_brand  varchar(100) DEFAULT NULL,
  device_carrier  varchar(100) DEFAULT NULL,
  device_model  varchar(100) DEFAULT NULL,
  lang  varchar(20) DEFAULT NULL,
  plat_id varchar(100) DEFAULT NULL,
  user_agent varchar(200) DEFAULT NULL,
  publisher_id varchar(100) DEFAULT NULL,
  publisher_name varchar(100) DEFAULT NULL,
  click_ip varchar(50) DEFAULT NULL,
  click_time datetime,
  bundle_id varchar(100) DEFAULT NULL,
  agency_name varchar(50) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  match_type varchar(50) DEFAULT NULL,
  campaign_id varchar(100) DEFAULT NULL,
  campaign_name varchar(100) DEFAULT NULL,
  ad_url varchar(200) DEFAULT NULL,
  ad_name varchar(250) DEFAULT NULL,
  region_name varchar(50) DEFAULT NULL,
  country_code varchar(20) DEFAULT NULL,
  currency_code varchar(10) DEFAULT NULL,
  existing_user boolean,
  imp_time datetime,
  stat_click_id varchar(200) DEFAULT NULL,
  stat_impression_id varchar(200) DEFAULT NULL,
  payout double,
  referral_source text DEFAULT NULL,
  referral_url text DEFAULT NULL,
  revenue double,
  revenue_usd double,
  status varchar(50) DEFAULT NULL,
  status_code varchar(20) DEFAULT NULL,
  tracking_id varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  ios_ifv varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  pub_camp_id varchar(50) DEFAULT NULL,
  pub_camp_name varchar(250) DEFAULT NULL,
  pub_camp_ref varchar(250) DEFAULT NULL,
  pub_adset varchar(250) DEFAULT NULL,
  pub_ad varchar(250) DEFAULT NULL,
  pub_keyword varchar(250) DEFAULT NULL,
  pub_place varchar(250) DEFAULT NULL,
  pub_sub_id varchar(250) DEFAULT NULL,
  pub_sub_name varchar(250) DEFAULT NULL,
  adv_camp_id varchar(250) DEFAULT NULL,
  adv_camp_name varchar(250) DEFAULT NULL,
  adv_camp_ref varchar(250) DEFAULT NULL,
  adv_adset varchar(250) DEFAULT NULL,
  adv_ad varchar(250) DEFAULT NULL,
  adv_keyword varchar(250) DEFAULT NULL,
  adv_place varchar(250) DEFAULT NULL,
  adv_sub_id varchar(250) DEFAULT NULL,
  adv_sub_name varchar(250) DEFAULT NULL,
  sdk varchar(20) DEFAULT NULL,
  sdk_version varchar(20) DEFAULT NULL,
  game_user_id varchar(200) DEFAULT NULL,
  os_jailbroke boolean,
  pub_pref_id varchar(250) DEFAULT NULL,
  pub_sub1 varchar(250) DEFAULT NULL,
  pub_sub2 varchar(250) DEFAULT NULL,
  pub_sub3 varchar(250) DEFAULT NULL,
  pub_sub4 varchar(250) DEFAULT NULL,
  pub_sub5 varchar(250) DEFAULT NULL,
  cost_model varchar(50) DEFAULT NULL,
  order_id varchar(200) DEFAULT NULL,
  cost double,
  ip_from int(10) unsigned zerofill,
  ip_to  int(10) unsigned zerofill,
  city_code varchar(20) DEFAULT NULL,
  is_proxy int default 0,
  proxy_type varchar(20) DEFAULT NULL,
  eval_prop float DEFAULT 0,
  key id (stat_id),
  key install_time (created),
  key aid ( ios_ifa, google_aid )
) default character set=utf8mb4 collate utf8mb4_general_ci;

drop table ad_event;
create table ad_event (
  id bigint auto_increment primary key,
  action varchar(50) DEFAULT 'install',
  account_key varchar(50) DEFAULT NULL,
  ip varchar(50) DEFAULT NULL,
  created datetime,
  source varchar(50) DEFAULT NULL,
  stat_id varchar(100) DEFAULT NULL,
  app_key varchar(100) DEFAULT NULL,
  os_version varchar(20) DEFAULT NULL,
  device_id varchar(100) DEFAULT NULL,
  device_type varchar(100) DEFAULT NULL,
  device_brand  varchar(100) DEFAULT NULL,
  device_carrier  varchar(100) DEFAULT NULL,
  device_model  varchar(100) DEFAULT NULL,
  lang  varchar(20) DEFAULT NULL,
  plat_id varchar(100) DEFAULT NULL,
  user_agent varchar(200) DEFAULT NULL,
  publisher_id varchar(100) DEFAULT NULL,
  publisher_name varchar(100) DEFAULT NULL,
  click_ip varchar(50) DEFAULT NULL,
  click_time datetime,
  bundle_id varchar(100) DEFAULT NULL,
  agency_name varchar(50) DEFAULT NULL,
  site_id varchar(50) DEFAULT NULL,
  site_name varchar(100) DEFAULT NULL,
  match_type varchar(50) DEFAULT NULL,
  campaign_id varchar(100) DEFAULT NULL,
  campaign_name varchar(100) DEFAULT NULL,
  ad_url varchar(200) DEFAULT NULL,
  ad_name varchar(250) DEFAULT NULL,
  region_name varchar(50) DEFAULT NULL,
  country_code varchar(20) DEFAULT NULL,
  currency_code varchar(10) DEFAULT NULL,
  existing_user boolean,
  imp_time datetime,
  stat_click_id varchar(200) DEFAULT NULL,
  stat_impression_id varchar(200) DEFAULT NULL,
  payout double,
  referral_source text DEFAULT NULL,
  referral_url text DEFAULT NULL,
  revenue double,
  revenue_usd double,
  status varchar(50) DEFAULT NULL,
  status_code varchar(20) DEFAULT NULL,
  tracking_id varchar(100) DEFAULT NULL,
  ios_ifa varchar(100) DEFAULT NULL,
  ios_ifv varchar(100) DEFAULT NULL,
  google_aid varchar(100) DEFAULT NULL,
  pub_camp_id varchar(50) DEFAULT NULL,
  pub_camp_name varchar(250) DEFAULT NULL,
  pub_camp_ref varchar(250) DEFAULT NULL,
  pub_adset varchar(250) DEFAULT NULL,
  pub_ad varchar(250) DEFAULT NULL,
  pub_keyword varchar(250) DEFAULT NULL,
  pub_place varchar(250) DEFAULT NULL,
  pub_sub_id varchar(250) DEFAULT NULL,
  pub_sub_name varchar(250) DEFAULT NULL,
  adv_camp_id varchar(250) DEFAULT NULL,
  adv_camp_name varchar(250) DEFAULT NULL,
  adv_camp_ref varchar(250) DEFAULT NULL,
  adv_adset varchar(250) DEFAULT NULL,
  adv_ad varchar(250) DEFAULT NULL,
  adv_keyword varchar(250) DEFAULT NULL,
  adv_place varchar(250) DEFAULT NULL,
  adv_sub_id varchar(250) DEFAULT NULL,
  adv_sub_name varchar(250) DEFAULT NULL,
  sdk varchar(20) DEFAULT NULL,
  sdk_version varchar(20) DEFAULT NULL,
  game_user_id varchar(200) DEFAULT NULL,
  os_jailbroke boolean,
  pub_pref_id varchar(250) DEFAULT NULL,
  pub_sub1 varchar(250) DEFAULT NULL,
  pub_sub2 varchar(250) DEFAULT NULL,
  pub_sub3 varchar(250) DEFAULT NULL,
  pub_sub4 varchar(250) DEFAULT NULL,
  pub_sub5 varchar(250) DEFAULT NULL,
  cost_model varchar(50) DEFAULT NULL,
  order_id varchar(200) DEFAULT NULL,
  cost double,
  ip_from int(10) unsigned zerofill,
  ip_to  int(10) unsigned zerofill,
  city_code varchar(20) DEFAULT NULL,
  is_proxy int default 0,
  proxy_type varchar(20) DEFAULT NULL,
  eval_prop float DEFAULT 0,
  key id (stat_id),
  key install_time (created),
  key aid ( ios_ifa, google_aid )
) default character set=utf8mb4 collate utf8mb4_general_ci;

CREATE TABLE `ad_dau` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(50) DEFAULT 'install',
  `account_key` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `stat_id` varchar(100) DEFAULT NULL,
  `app_key` varchar(100) DEFAULT NULL,
  `os_version` varchar(20) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `device_type` varchar(100) DEFAULT NULL,
  `device_brand` varchar(100) DEFAULT NULL,
  `device_carrier` varchar(100) DEFAULT NULL,
  `device_model` varchar(100) DEFAULT NULL,
  `lang` varchar(20) DEFAULT NULL,
  `plat_id` varchar(100) DEFAULT NULL,
  `user_agent` varchar(200) DEFAULT NULL,
  `publisher_id` varchar(100) DEFAULT NULL,
  `publisher_name` varchar(100) DEFAULT NULL,
  `click_ip` varchar(50) DEFAULT NULL,
  `click_time` datetime DEFAULT NULL,
  `bundle_id` varchar(100) DEFAULT NULL,
  `agency_name` varchar(50) DEFAULT NULL,
  `site_id` varchar(50) DEFAULT NULL,
  `site_name` varchar(100) DEFAULT NULL,
  `match_type` varchar(50) DEFAULT NULL,
  `campaign_id` varchar(100) DEFAULT NULL,
  `campaign_name` varchar(100) DEFAULT NULL,
  `ad_url` varchar(200) DEFAULT NULL,
  `ad_name` varchar(250) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `country_code` varchar(20) DEFAULT NULL,
  `currency_code` varchar(10) DEFAULT NULL,
  `existing_user` tinyint(1) DEFAULT NULL,
  `imp_time` datetime DEFAULT NULL,
  `stat_click_id` varchar(200) DEFAULT NULL,
  `stat_impression_id` varchar(200) DEFAULT NULL,
  `payout` double DEFAULT NULL,
  `referral_source` text,
  `referral_url` text,
  `revenue` double DEFAULT NULL,
  `revenue_usd` double DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `status_code` varchar(20) DEFAULT NULL,
  `tracking_id` varchar(100) DEFAULT NULL,
  `ios_ifa` varchar(100) DEFAULT NULL,
  `ios_ifv` varchar(100) DEFAULT NULL,
  `google_aid` varchar(100) DEFAULT NULL,
  `pub_camp_id` varchar(50) DEFAULT NULL,
  `pub_camp_name` varchar(250) DEFAULT NULL,
  `pub_camp_ref` varchar(250) DEFAULT NULL,
  `pub_adset` varchar(250) DEFAULT NULL,
  `pub_ad` varchar(250) DEFAULT NULL,
  `pub_keyword` varchar(250) DEFAULT NULL,
  `pub_place` varchar(250) DEFAULT NULL,
  `pub_sub_id` varchar(250) DEFAULT NULL,
  `pub_sub_name` varchar(250) DEFAULT NULL,
  `adv_camp_id` varchar(250) DEFAULT NULL,
  `adv_camp_name` varchar(250) DEFAULT NULL,
  `adv_camp_ref` varchar(250) DEFAULT NULL,
  `adv_adset` varchar(250) DEFAULT NULL,
  `adv_ad` varchar(250) DEFAULT NULL,
  `adv_keyword` varchar(250) DEFAULT NULL,
  `adv_place` varchar(250) DEFAULT NULL,
  `adv_sub_id` varchar(250) DEFAULT NULL,
  `adv_sub_name` varchar(250) DEFAULT NULL,
  `sdk` varchar(20) DEFAULT NULL,
  `sdk_version` varchar(20) DEFAULT NULL,
  `game_user_id` varchar(200) DEFAULT NULL,
  `os_jailbroke` tinyint(1) DEFAULT NULL,
  `pub_pref_id` varchar(250) DEFAULT NULL,
  `pub_sub1` varchar(250) DEFAULT NULL,
  `pub_sub2` varchar(250) DEFAULT NULL,
  `pub_sub3` varchar(250) DEFAULT NULL,
  `pub_sub4` varchar(250) DEFAULT NULL,
  `pub_sub5` varchar(250) DEFAULT NULL,
  `cost_model` varchar(50) DEFAULT NULL,
  `order_id` varchar(200) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `ip_from` bigint(20) DEFAULT '0',
  `ip_to` bigint(20) DEFAULT '0',
  `city_code` varchar(20) DEFAULT NULL,
  `proxy_type` varchar(20) DEFAULT NULL,
  `eval_prop` float DEFAULT '0',
  `is_proxy` int(11) DEFAULT '0',
  `attr1` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`stat_id`),
  KEY `install_time` (`created`),
  UNIQUE KEY `user` (`created`,`plat_id`,game_user_id)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

alter table ad_install add column is_proxy int default 0;
alter table ad_install change metro_code proxy_type varchar(20) DEFAULT NULL;
alter table ad_click add column is_proxy int default 0;
alter table ad_click change metro_code proxy_type varchar(20) DEFAULT NULL;
alter table ad_event add column is_proxy int default 0;
alter table ad_event change metro_code proxy_type varchar(20) DEFAULT NULL;
alter table ad_purchase add column is_proxy int default 0;
alter table ad_purchase change metro_code proxy_type varchar(20) DEFAULT NULL;

alter table ad_install change ip_from ip_from bigint default 0;
alter table ad_install change ip_to ip_to bigint default 0;
alter table ad_click change ip_from ip_from bigint default 0;
alter table ad_click change ip_to ip_to bigint default 0;
alter table ad_purchase change ip_from ip_from bigint default 0;
alter table ad_purchase change ip_to ip_to bigint default 0;
alter table ad_event change ip_from ip_from bigint default 0;
alter table ad_event change ip_to ip_to bigint default 0;

alter table ad_install drop column postback_code;
alter table ad_install drop column postback_desc;
alter table ad_click drop column postback_code;
alter table ad_click drop column postback_desc;
alter table ad_purchase drop column postback_code;
alter table ad_purchase drop column postback_desc;
alter table ad_event drop column postback_code;
alter table ad_event drop column postback_desc;

drop table ad_flow;
CREATE TABLE `ad_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_key` varchar(50) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `stat_id` varchar(100) DEFAULT NULL,
  `app_key` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `site_id` varchar(50) DEFAULT NULL,
  `site_name` varchar(100) DEFAULT NULL,
  `country_code` varchar(20) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `game_user_id` varchar(100) DEFAULT NULL,
  `uid` varchar(100) DEFAULT NULL,
  `plat_id` varchar(100) DEFAULT NULL,
  `publisher_id` varchar(50) DEFAULT NULL,
  `publisher_name` varchar(50) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `device_model` varchar(50) DEFAULT NULL,
  `install_time` datetime DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `os_version` varchar(100) DEFAULT NULL,
  `logins` int(11) DEFAULT '0',
  `step1` varchar(30) DEFAULT NULL,
  `step1_interval` int(11) DEFAULT '0',
  `step2` varchar(30) DEFAULT NULL,
  `step2_interval` int(11) DEFAULT '0',
  `step3` varchar(30) DEFAULT NULL,
  `step3_interval` int(11) DEFAULT '0',
  `step4` varchar(30) DEFAULT NULL,
  `step4_interval` int(11) DEFAULT '0',
  `step5` varchar(30) DEFAULT NULL,
  `step5_interval` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ukey` (`account_key`,`source`,`site_name`,`created`,`uid`),
  KEY `stat_id` (`stat_id`),
  KEY `created` (`created`),
  KEY `install_time` (`install_time`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop table ad_currency;
create table ad_currency (
  id int(11) primary key auto_increment,
  created date,
  currency_code char(3),
  rate double,
  unique key idx (created, currency_code)
) default character set=utf8mb4 collate utf8mb4_general_ci;

/**
 * Add Adwords Link ID to AfSite
 */

alter table af_site add column adwords_link_id varchar(100) DEFAULT NULL;


