package com.eco.dao;

import org.apache.ibatis.annotations.Mapper;

import com.eco.dto.search.SearchDTO;

@Mapper
public interface ICountDao {
	int getAllCount(String tablename, String fieldname, String key);
	int mygetAllCount(String tablename, String fieldname, String key);
	int getAllCountAll(String table);
	int count(SearchDTO search);
}