package com.liang.cpes.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.cpes.dao.CerttypeDao;

@Service
public class CerttypeServiceImpl implements CerttypeService {

	@Autowired
	private CerttypeDao certtypeDao;
}
