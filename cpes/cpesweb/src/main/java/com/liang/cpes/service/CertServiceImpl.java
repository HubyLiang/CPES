package com.liang.cpes.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.bean.AcctCert;
import com.liang.cpes.bean.Datas;
import com.liang.cpes.bean.Page;
import com.liang.cpes.bean.T_Cert;
import com.liang.cpes.dao.CertDao;

@Service
public class CertServiceImpl implements CertService {

	@Autowired
	private CertDao certDao;

	public Page<T_Cert> queryCertPage(Map<String, Object> paramMap) {
		Page<T_Cert> certPage = new Page<T_Cert>();

		List<T_Cert> certs = certDao.queryCertPage(paramMap);
		int count = certDao.queryCertCount(paramMap);

		certPage.setDatas(certs);
		certPage.setTotalsize(count);

		return certPage;
	}

	public int insertCert(T_Cert cert) {
		return certDao.insertCert(cert);
	}

	public T_Cert queryCertById(Integer id) {
		return certDao.queryCertById(id);
	}

	public int updateCert(T_Cert cert) {
		return certDao.updateCert(cert);
	}

	public int deleteCert(Integer id) {
		return certDao.deleteCert(id);
	}

	public void deleteCerts(Datas ds) {
		certDao.deleteCerts(ds);
	}

	public List<T_Cert> queryAllCert() {
		return certDao.queryAllCert();
	}

	public void insertAccCert(Map<String, Object> paramMap) {
		certDao.insertAccCert(paramMap);
	}

	public List<AcctCert> queryAccCerts() {
		return certDao.queryAccCerts();
	}

	public void deleteAccCert(Map<String, Object> paramMap) {
		certDao.deleteAccCert(paramMap);
	}

	public List<T_Cert> queryCertsByMemberAccttype(String accttype) {
		return certDao.queryCertsByMemberAccttype(accttype);
	}

}
