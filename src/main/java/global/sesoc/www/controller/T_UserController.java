package global.sesoc.www.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.www.dao.T_UserRepository;
import global.sesoc.www.dto.T_User;
import global.sesoc.www.util.FileService;

@Controller
public class T_UserController {

	@Autowired
	T_UserRepository repository;

	final String uploadPath = "/uploadPath";

	// 회원가입화면요청
	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String signUp() {
		return "user/signUp";
	}

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(T_User user, HttpSession session, Model model) {

		T_User t = repository.selectOne(user);
		if (t != null) {
			session.setAttribute("loginId", t.getUserId());
			session.setAttribute("loginName", t.getUserId());
			model.addAttribute("user", t);
		} else {
			model.addAttribute("islogined", "1");
			return "index";
		}
		return "main";
	}

	// 회원가입
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String signUp(T_User user, Model model, MultipartFile upload) {
		String savedImage = null;
		String originalImage = null;
		if (!upload.isEmpty()) {
			savedImage = FileService.saveFile(upload, uploadPath);
			originalImage = upload.getOriginalFilename();
		}
		user.setOriginalImage(originalImage);
		user.setSavedImage(savedImage);

		int result = repository.signUp(user);

		if (result != 1) {
			model.addAttribute("message", "회원가입이 실패하였습니다. 다시 회원가입을 해주세요.");
		} else {
			model.addAttribute("message", "회원가입이 성공하였습니다.");
		}
		return "message";
	}

	@RequestMapping(value = "/duplicateCheck", method = RequestMethod.POST)
	public @ResponseBody int duplicateCheck(String userId) {
		T_User user = new T_User();
		user.setUserId(userId);
		if (userId.length() < 3) {
			return 3;
		}
		if (repository.selectOne(user) != null) {
			return 1;
		} else {
			return 0;
		}
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}

	// 내프로필 화면 요청
	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String userDetail(HttpSession session, Model model, String userId) {
		T_User user = new T_User();
		user.setUserId(userId);

		T_User t = repository.selectOne(user);
		String p1 = t.getPhone();
		String[] p2 = p1.split(",");
		String phone1 = p2[0];
		String phone2 = p2[1];
		model.addAttribute("phone1", phone1);
		model.addAttribute("phone2", phone2);
		model.addAttribute("user", t);
		String mime = null;
		if (t.getOriginalImage() != null) {
			String fullPath = uploadPath + "/" + t.getSavedImage();
			try {
				String type = Files.probeContentType(Paths.get(fullPath));
				if(type != null && type.contains("image")) {
					model.addAttribute("mime", type);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} 	
    	return "user/userDetail";
    }
    //회원 정보 수정 처리
  	@RequestMapping(value="/userUpdate", method=RequestMethod.POST)
  	public String userUpdate(HttpSession session, T_User user, MultipartFile upload) {
  		String userId = (String) session.getAttribute("loginId");
  		user.setUserId(userId);
    	System.out.println("업로드여부 : " + upload + ", 파일의 크기" + upload.getSize() + ", 파일이 비었는지 여부 : " + upload.isEmpty());
    	T_User t = repository.selectOne(user);
    	
    	if(user.getSavedImage() != null) {
    		String fullPath = uploadPath + "/"+ t.getSavedImage();
    		FileService.deleteFile(fullPath);
    	}
    	if(!upload.isEmpty()) {
    		String savedImage = FileService.saveFile(upload, uploadPath);
    		String originalImage = upload.getOriginalFilename();
	
			user.setOriginalImage(originalImage);
			user.setSavedImage(savedImage);	
		}
  		repository.userUpdate(user);
  		return "redirect:/userDetail";
  	}
  	

	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public String download(HttpSession session, T_User t, HttpServletResponse response,String userId) {
		t.setUserId(userId);
		T_User user = repository.selectOne(t);
		String originalImage = user.getOriginalImage();
		String fullPath = uploadPath + "/" + user.getSavedImage();
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+URLEncoder.encode(originalImage, "UTF-8")); //Content-Disposition: 어떤 종류의 파일이 전송되어간다를 알려줌.
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		FileInputStream fin = null;
		ServletOutputStream fileout = null;
		System.out.println("originalImage::"+originalImage);
		try {
			fin = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			FileCopyUtils.copy(fin, fileout);
			
			fin.close();
			fileout.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}

	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String userDelete() {
		return "user/userDelete";
	}
	
	@RequestMapping(value = "/pwdUpdate", method = RequestMethod.GET)
	public String pwdUpdate() {
		return "user/pwdUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwdCheck", method = RequestMethod.POST)
	public T_User pwdCheck(@RequestBody T_User user, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user.setUserId(userId);
		T_User t = repository.selectOne(user);
		return t;
	}

	@ResponseBody
	@RequestMapping(value = "/pwdUpdate", method = RequestMethod.POST)
	public int pwdUpdate(@RequestBody T_User user, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		user.setUserId(userId);
		int t = repository.userUpdate(user);
		return t;
	}

	@ResponseBody
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String userDelete(HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		String result = "";
		int r = repository.userDelete(userId);
		if (r == 1) {
			result = "1";
		} else {
			result = "0";
		}
		return result;
	}

	@RequestMapping(value = "/usersearch", method = RequestMethod.POST)
	public String usersearch(String userName, Model model, HttpSession session, T_User user) {
		String loginId = (String) session.getAttribute("loginId");
		String loginName = (String) session.getAttribute("loginName");

		System.out.println(userName);
		user.setUserName(userName);
		List<T_User> userList = repository.searchName(user);

		if (userList.size() == 0) {
			user.setUserName(null);
			String userId = userName;
			user.setUserId(userId);
			userList = repository.searchName(user);
		}

		for (int i = 0; i < userList.size(); i++) {
			if (userList.get(i).getUserId().equals(loginId) || userList.get(i).getUserName().equals(loginName)) { // 자기이름검색
																													// 불가
				userList.remove(i);
			}
		}
		model.addAttribute("searchWord", userName);
		model.addAttribute("list", userList);
		return "friend/searchResult";
	}
	
	@ResponseBody
	@RequestMapping(value = "/villageUpload", method = RequestMethod.GET)
	public String villageUpload(HttpSession session, String village) {
		String result = "";
		session.setAttribute("village", village);
		return result;
	}
}
