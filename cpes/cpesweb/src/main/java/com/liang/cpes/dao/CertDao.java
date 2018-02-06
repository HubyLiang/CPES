package com.liang.cpes.dao;

import java.util.List;
import java.util.Map;

import com.liang.cpes.bean.AcctCert;
import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.T_Cert;

public interface CertDao {

	List<T_Cert> queryCertPage(Map<String, Object> paramMap);

	int queryCertCount(Map<String, Object> paramMap);

	int insertCert(T_Cert cert);

	T_Cert queryCertById(Integer id);

	int updateCert(T_Cert cert);

	int deleteCert(Integer id);

	void deleteCerts(Datas ds);

	List<T_Cert> queryAllCert();

	void insertAccCert(Map<String, Object> paramMap);

	List<AcctCert> queryAccCerts();

	void deleteAccCert(Map<String, Object> paramMap);

	List<T_Cert> queryCertsByMemberAccttype(String accttype);

}
