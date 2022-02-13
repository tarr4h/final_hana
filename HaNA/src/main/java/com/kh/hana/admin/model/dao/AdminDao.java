package com.kh.hana.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDao {

	List<Map<String, Object>> selectSearchStatistics(Map<String, Object> param);

	int insertHashtag(String name);

	int deleteHashtag(String name);

}
