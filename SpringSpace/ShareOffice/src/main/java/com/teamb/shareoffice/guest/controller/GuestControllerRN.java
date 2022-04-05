package com.teamb.shareoffice.guest.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamb.shareoffice.commons.KakaoRestAPI;
import com.teamb.shareoffice.guest.service.GuestServiceB;
import com.teamb.shareoffice.guest.service.GuestServiceRN;
import com.teamb.shareoffice.member.service.MemberServiceRN;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.KakaopayVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;

@Controller
@RequestMapping("/guest/*")
public class GuestControllerRN {
	
	@Autowired
	private MemberServiceRN memberService;
	
	@Autowired
	private GuestServiceB guestServiceB;
	
	@Autowired
	private GuestServiceRN guestServiceRN;
	
	// for pc
	@RequestMapping("kakaoPayApproval")
	public String kakaoPayApproval(String pg_token, HttpSession session, Model model) {
		String kakaoKey = memberService.getKakaoKey();

		KakaopayVo vo = (KakaopayVo) session.getAttribute("kakaopayVo");
		
		KakaoRestAPI kakao = new KakaoRestAPI();
		Map<String, Object> result = kakao.payApprove(pg_token, vo, session, kakaoKey);	
		
		model.addAttribute("response_code", result.get("response_code"));
		session.removeAttribute("kakaopayVo");
		
		return "guest/payDone";
	}
	
	
	// for mobile
	/*@RequestMapping("kakaoPayApproval")
	public String kakaoPayApproval(String pg_token, HttpSession session, Model model) {
		String kakaoKey = memberService.getKakaoKey();
	
		KakaopayVo vo = (KakaopayVo) session.getAttribute("kakaopayVo");
		
		KakaoRestAPI kakao = new KakaoRestAPI();
		Map<String, Object> result = kakao.payApprove(pg_token, vo, session, kakaoKey);	
		
		session.removeAttribute("kakaopayVo");
		
		if(Integer.valueOf(String.valueOf(result.get("response_code"))) == 200) {
			return "redirect:../guest/orderProcess";
		}

		return "redirect:../guest/kakaoPayFail";
	}*/
	
	@RequestMapping("kakaoPayCancel")
	public String kakaoPayCancel(HttpSession session) {
		session.removeAttribute("kakaopayVo");
		session.removeAttribute("params");
		session.removeAttribute("tid");
		
		return "guest/payCancel";
	}
	
	@RequestMapping("kakaoPayFail")
	public String kakaoPayFail(HttpSession session) {
		session.removeAttribute("kakaopayVo");
		session.removeAttribute("params");
		session.removeAttribute("tid");
		
		return "guest/payFail";
	}
	
	
	// for pc
	@RequestMapping("orderProcess")
	public String paymentProcess(Model model, HttpSession session, OrderVo orderVo, Date[] rental_date, int allot_no, int coupon_discount) {
		
		int discountPrice = 0;
		if(coupon_discount > 0) {
			discountPrice = coupon_discount / rental_date.length;	
		}
		
		orderVo.setMember_no(((MemberVo) session.getAttribute("sessionUser")).getMember_no());
		
		String[] weekList = {"일", "월", "화", "수", "목", "금", "토"};
		
		ArrayList<RentalVo> rentalVoList = new ArrayList<>();
		for(Date rentalDay : rental_date) {
			RentalVo rentalVo = new RentalVo();
			
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(rentalDay);
			
			String day = weekList[calendar.get(Calendar.DAY_OF_WEEK)-1];
			
			System.out.println("rentalDay : " +rentalDay + ", day : " + day + ", office_no : " + orderVo.getOffice_no());
			
			BusinessDayVo businessDayVo = new BusinessDayVo();
			
			businessDayVo.setOffice_no(orderVo.getOffice_no());
			
			businessDayVo.setBusiness_day(day);
			
			rentalVo.setRental_date(rentalDay);
			rentalVo.setRental_price(guestServiceB.getPriceAndBusiunessTime(businessDayVo).getBusiness_day_price() - discountPrice);
			
			rentalVoList.add(rentalVo);

		}
		
		guestServiceRN.order(orderVo, rentalVoList);
		
		if(allot_no > 0) {
			guestServiceRN.useCoupon(allot_no);
		}
		
		return "redirect:../guest/officeRentalDetailPage?office_no=" + orderVo.getOffice_no();
	}
	
	
	// for mobile
	/*@RequestMapping("orderProcess")
	public String paymentProcess(Model model, HttpSession session) {
		
		HashMap<String, Object> params = (HashMap<String, Object>) session.getAttribute("params");
		
		String tid = String.valueOf(session.getAttribute("tid"));
		ArrayList<String> rental_date = (ArrayList<String>) params.get("rental_date");
		int allot_no = Integer.valueOf(String.valueOf(params.get("allot_no")));
		int coupon_discount = Integer.valueOf(String.valueOf(params.get("coupon_discount")));
		int discountPrice = 0;
		if(coupon_discount > 0) {
			discountPrice = coupon_discount / rental_date.size();	
		}
		
		
		OrderVo orderVo = new OrderVo();
		
		orderVo.setOffice_no(Integer.valueOf(String.valueOf((params.get("office_no")))));
		orderVo.setOrder_personnel(Integer.valueOf(String.valueOf((params.get("order_personnel")))));
		orderVo.setOrder_tid(tid);
		
		orderVo.setMember_no(((MemberVo) session.getAttribute("sessionUser")).getMember_no());
		
		String[] weekList = {"일", "월", "화", "수", "목", "금", "토"};
		
		ArrayList<RentalVo> rentalVoList = new ArrayList<>();
		for(String rentalDay : rental_date) {
			RentalVo rentalVo = new RentalVo();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date rentalDay2;
			try {
				rentalDay2 = sdf.parse(rentalDay);
			
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(rentalDay2);
			
			String day = weekList[calendar.get(Calendar.DAY_OF_WEEK)-1];
			
			BusinessDayVo businessDayVo = new BusinessDayVo();
			
			businessDayVo.setOffice_no(orderVo.getOffice_no());
			
			businessDayVo.setBusiness_day(day);
			
			rentalVo.setRental_date(rentalDay2);
			rentalVo.setRental_price(guestServiceB.getPriceAndBusiunessTime(businessDayVo).getBusiness_day_price() - discountPrice);
			
			rentalVoList.add(rentalVo);
			} catch (ParseException e) {
				System.out.println("parse date 익셉션]" + e.getMessage());
			}
		}
		
		guestServiceRN.order(orderVo, rentalVoList);
		
		if(allot_no > 0) {
			guestServiceRN.useCoupon(allot_no);
		}
		
		session.removeAttribute("kakaopayVo");
		session.removeAttribute("params");
		session.removeAttribute("tid");
		
		return "redirect:../guest/officeRentalDetailPage?office_no=" + orderVo.getOffice_no();
	}*/
	
	@RequestMapping("officeRentalDetailPage")
	public String officeRentalDetailPage(int office_no) {
		
		return "guest/officeRentalDetailPage";
	}
	
}