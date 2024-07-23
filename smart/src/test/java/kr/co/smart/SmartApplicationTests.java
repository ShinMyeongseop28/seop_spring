package kr.co.smart;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import kr.co.smart.customer.CustomerMapper;
import kr.co.smart.customer.CustomerVO;

@SpringBootTest
class SmartApplicationTests {

	@Autowired private CustomerMapper mapper;  // 필드주입
	@Test
	void customerLoads() {
		List<CustomerVO> list = mapper.getListOfCustomer();
		System.out.println(list.size());
	}

}
