package com.project.BonusPointExchangePlatform.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.BonusPointExchangePlatform.dao.AccountDao;
import com.project.BonusPointExchangePlatform.dao.MemberDao;
import com.project.BonusPointExchangePlatform.dto.MemberDto;
import com.project.BonusPointExchangePlatform.model.Account;
import com.project.BonusPointExchangePlatform.model.Member;
import com.project.BonusPointExchangePlatform.model.goodphoto;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private AccountDao aDao;

	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy/MM/dd");
	SimpleDateFormat DateTimeFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	public void insertMember(Member member) {
		memberDao.save(member);
	}

	public Member findIdByEmail(String email) {
		return memberDao.findIdByEmail(email);
	}

//	public Member showMemberById(Integer id) {
//		
//		mDao.showMemberById(id);
//		System.out.println(mDao.showMemberById(id));
//		
//		if(mDao.showMemberById(id) != null) {
//			return mDao.showMemberById(id);
//		}else
//		return null;
//	}
//	
	public Account showMemberById(Integer id) {
		aDao.showMemberById(id);
		System.out.println(aDao.showMemberById(id));

		if (aDao.showMemberById(id) != null) {
			return aDao.showMemberById(id);
		} else
			return null;
	}

	public Member showMemberBankById(Integer id) {
		memberDao.showMemberBankById(id);
		System.out.println(memberDao.showMemberBankById(id));

		if (memberDao.showMemberBankById(id) != null) {
			return memberDao.showMemberBankById(id);
		} else
			return null;
	}

	public Map<String, Object> editMemberDetail(String name, LocalDate birth, String email, String phone,
			String password, byte[] image, Integer id) {
		Map<String, Object> map = new HashMap<>();
		memberDao.editMemberDetail(name, birth, email, phone, image, id);
		aDao.editAccountDetail(password, id);
		Member m = memberDao.findById(id).get();
		Account a = aDao.findById(id).get();
		map.put("Member", m);
		map.put("Account", a);

		return map;
	}


	public List<MemberDto> getAllMember(String orderby) {
		List<Account> type;
		if(orderby!=null&&orderby.equals("ASC")) {
			type = aDao.getAccountTypeByASC();
		}else {
			type = aDao.getAccountTypeByDESC();
		}
			
		List<MemberDto> memberDto = new ArrayList<MemberDto>();
		if (type != null) {
			for (Account X : type) {
				MemberDto member = new MemberDto();
				member.setAccount_type(X.getAccount_type());
				member.setMember(X.getMember());
				member.setDateBirth(DateFormat.format(X.getMember().getBirth()));
				member.setDateCreate(DateTimeFormat.format(X.getMember().getCreate_at()));
				member.setDateUpdate(DateTimeFormat.format(X.getMember().getUpdate_at()));
				memberDto.add(member);
			}

			return memberDto;

		} else
			return null;

	}

	public List<MemberDto> getAllMemberSearch(String name , String orderby) {
	
		List<MemberDto> memberDto = new ArrayList<MemberDto>();
		if (name != " ") {
			
			List<Account> type;
			System.out.println(orderby);
			if(orderby!=null&&orderby.equals("ASC")) {
				type = aDao.getAccountTypeSearchByASC("%" + name + "%");
			}else {
				type = aDao.getAccountTypeSearchByDESC("%" + name + "%");
			}
			
			for (Account X : type) {
				MemberDto member = new MemberDto();
				member.setAccount_type(X.getAccount_type());
				member.setMember(X.getMember());
				member.setDateBirth(DateFormat.format(X.getMember().getBirth()));
				member.setDateCreate(DateTimeFormat.format(X.getMember().getCreate_at()));
				member.setDateUpdate(DateTimeFormat.format(X.getMember().getUpdate_at()));
				memberDto.add(member);
			}
			System.out.println(memberDto);
			
		}else{
			List<Account> type1;
			System.out.println(orderby);
			if(orderby!=null&&orderby.equals("ASC")) {
				type1 = aDao.getAccountTypeSearchByASC("%" + name + "%");
			}else {
				type1 = aDao.getAccountTypeSearchByDESC("%" + name + "%");
			}

			if (type1 != null) {
				for (Account X : type1) {
					MemberDto member = new MemberDto();
					member.setAccount_type(X.getAccount_type());
					member.setMember(X.getMember());
					member.setDateBirth(DateFormat.format(X.getMember().getBirth()));
					member.setDateCreate(DateTimeFormat.format(X.getMember().getCreate_at()));
					member.setDateUpdate(DateTimeFormat.format(X.getMember().getUpdate_at()));
					memberDto.add(member);
				}
				System.out.println(memberDto);

				
			}
		}
		if(memberDto!=null) {
		return memberDto;
		}else
			return null;
	}

	public void editBacknedMemberDetail(String name, LocalDate birth, String email, String phone,
			byte[] image2, Integer id ) {
		
		memberDao.editBacknedMemberDetail(name, birth, email, phone, image2, id);

	}

	public MemberDto findOnebyId(int id) {
		Member member = memberDao.findOnebyId(id);
		MemberDto dto = new MemberDto();
		dto.setMember(member);
		dto.setDateBirth(DateFormat.format(member.getBirth()));
		dto.setDateCreate(DateTimeFormat.format(member.getCreate_at()));
		dto.setDateUpdate(DateTimeFormat.format(member.getUpdate_at()));
		return dto;
	}
	
	
	public List<MemberDto> restorepermission(int id , int newtype , String orderby) {
		System.out.println(id);
		System.out.println(newtype);
		aDao.restorepermission(id,newtype);
		
		List<Account> all ;
		System.out.println(orderby);
		if(orderby!=null&&orderby.equals("ASC")) {
			all = aDao.getAccountTypeByASC();
		}else {
			all = aDao.getAccountTypeByDESC();
		}

		List<MemberDto> memberDto = new ArrayList<MemberDto>();
		if (all != null) {
			for (Account X : all) {
				MemberDto member = new MemberDto();
				member.setAccount_type(X.getAccount_type());
				member.setMember(X.getMember());
				member.setDateBirth(DateFormat.format(X.getMember().getBirth()));
				member.setDateCreate(DateTimeFormat.format(X.getMember().getCreate_at()));
				member.setDateUpdate(DateTimeFormat.format(X.getMember().getUpdate_at()));
				memberDto.add(member);
			}
		

			return memberDto;

		} else
			return null;

	}
	
	public Member geticonphoto(Integer id) {
		Account account = aDao.showMemberById(id);
		Member member = account.getMember();
		return member;
	}
	
	
	//才蔚
	public List<Member> findIdByName(String search) {
		return memberDao.findByName("%" + search + "%");
	}
	
	//書瑋
	/* 根據email得到Member Bean 確認註冊帳號是否重複 */
	public Member getBeanByEmail(String email) {
	 Member member = memberDao.findIdByEmail(email);
		return member ;
	}
}
