package com.kh.hana.shop.model.dao;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.hana.shop.model.vo.HashTag;
import com.kh.hana.shop.model.vo.Table;
@Repository
public class ShopDaoImpl implements ShopDao {
	
    @Autowired
    public SqlSession session;
    
    @Override
    public List<Map<String, Object>> selectShopList(Map<String, Object> data) {
    		return session.selectList("shop.selectShopList", data);
    }
    
    @Override
    public int insertHashTag(HashTag hashTag) {
        return session.insert("shop.insertHashTag", hashTag);
    }
    
    @Override public List<HashTag> hashTagAutocomplete(String search) { 
        return session.selectList("shop.selectHashTagList", search); 
    }

	@Override
	public String verifyTableName(Table table) {
		return session.selectOne("shop.verifyTableName", table);
	}

	@Override
	public int insertShopTable(Table table) {
		return session.insert("shop.insertShopTable", table);
	}

	@Override
	public List<Table> selectShopTableList(String id) {
		return session.selectList("shop.selectShopTableList", id);
	}

	@Override
	public int deleteShopTable(String tableId) {
		return session.delete("shop.deleteShopTable", tableId);
	}

	@Override
	public int updateShopTable(Table table) {
		return session.update("shop.updateShopTable", table);
	}

	@Override
	public Table selectOneTable(Table table) {
		return session.selectOne("shop.selectOneTable", table);
	}

	@Override
	public List<Map<String, Object>> selectHashTagShopList(Map<String, Object> data) {
		return session.selectList("shop.selectHashTagShopList",data);
	}


	
	 

	
    
}