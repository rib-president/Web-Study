package com.lotto.shinnanda.member.mapper;

import java.util.*;

import com.lotto.shinnanda.vo.MemberVo;

public interface MemberSQLMapper {
		
		//insert, update, delete는  return 타입이 void
		//select는 return 타입이 존재해야 함
		public void joinMember(MemberVo vo);	//insert
		
		public MemberVo getMemberByIdAndPw(MemberVo vo);	//select
		
		public MemberVo getMemberByNo(int no);
		
		public void updateMemberVo(MemberVo vo);
		
		public ArrayList<MemberVo> selectMember();
		
		public MemberVo selectMemberById(String member_id);
		
		public int getCountMemberById(String member_id);
}


