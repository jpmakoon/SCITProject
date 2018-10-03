package global.sesoc.www.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.T_GrequestRepository;
import global.sesoc.www.dao.T_GroupRepository;
import global.sesoc.www.dto.T_Grequest;
import global.sesoc.www.dto.T_GrequestUser;
import global.sesoc.www.dto.T_Group;

@Controller
public class T_GrequestController {
   @Autowired
   T_GrequestRepository T_GRequestRepository;
   @Autowired
   T_GroupRepository T_GroupRepository;

   @ResponseBody
   @RequestMapping(value = "/checkGrequest", method = RequestMethod.POST)
   public int checkGrequest(@RequestBody T_Grequest gRequest, HttpSession session) {
      String userId = (String) session.getAttribute("loginId"); // 현재 유저 id
      T_Group g = new T_Group();
      g.setGroNum(gRequest.getGroNum());
      T_Group group = T_GroupRepository.selectOneGroup(g);
      String groupUserId = group.getUserId(); // 그룹 장의 id

      List<T_Grequest> gList = T_GRequestRepository.selectGrequest(gRequest);
      int result = 1;

      if (userId.equals(groupUserId)) {// 가입신청 유저가 모임장일 경우
         result = 0;
         return result;
      }
      for (int i = 0; i < gList.size(); i++) {
         if (gList.get(i).getIsgreqAccepter() == 0) {
            if (gList.get(i).getgRequester().equals(userId)) {
               result = 2; // 가입 신청자가 다시 가입 신청을 누를 때
            }
         } else if (gList.get(i).getIsgreqAccepter() == 1) {
            if (gList.get(i).getgRequester().equals(userId)) {
               result = 3; // 해당 모임의 회원(이미 가입 된 유저)이 가입신청을 누를 때
            }
         }
      }
      return result;
   }

   @ResponseBody
   @RequestMapping(value = "/insertGrequest", method = RequestMethod.POST)
   public int insertGrequest(@RequestBody T_Grequest gRequest, HttpSession session) {

      T_Group g = new T_Group();
      g.setGroNum(gRequest.getGroNum());
      T_Group group = T_GroupRepository.selectOneGroup(g);
      gRequest.setGreqAccepter(group.getUserId());

      String gRequester = (String) session.getAttribute("loginId");
      gRequest.setgRequester(gRequester);
      int result = T_GRequestRepository.insertGrequest(gRequest);
      return result;
   }

   @ResponseBody
   @RequestMapping(value = "/isAccepted", method = RequestMethod.POST)
   public int isAccepted(HttpSession session) {
      int result = 1;

      String userId = (String) session.getAttribute("loginId");
      List<T_Grequest> list = T_GRequestRepository.groupAccept(userId);
      if (list.size() == 0) {
         result = 0;
      }
      return result;
   }

   @RequestMapping(value = "/groupApply", method = RequestMethod.GET)
   public String groupApply(HttpSession session, Model model) {
      String userId = (String) session.getAttribute("loginId");
      List<T_GrequestUser> list = T_GRequestRepository.selectGreqUsers(userId);
      model.addAttribute("list", list);
      return "group/groupApply";
   }

   @ResponseBody
   @RequestMapping(value = "/applySuccess", method = RequestMethod.POST)
   public int applySuccess(@RequestBody T_Grequest gRequest, HttpSession session) {
      String userId = (String) session.getAttribute("loginId");
      gRequest.setGreqAccepter(userId);
      int result = T_GRequestRepository.applySuccess(gRequest);
      return result;
   }

   @ResponseBody
   @RequestMapping(value = "/applyCancel", method = RequestMethod.POST)
   public int applyCancel(@RequestBody T_Grequest gRequest, HttpSession session) {
	  String userId = (String) session.getAttribute("loginId");
	  gRequest.setGreqAccepter(userId);
	  int result = T_GRequestRepository.applyCancel(gRequest);
      return result;
   }

   @ResponseBody
   @RequestMapping(value = "/inviteFriend", method = RequestMethod.POST)
   public int inviteFriend(@RequestBody T_Grequest grequest, HttpSession session) {
      String userId = (String) session.getAttribute("loginId");
      grequest.setGreqAccepter(userId);
      List<T_Grequest> checkList = T_GRequestRepository.checkInvite(grequest);

      if (checkList.size() != 0) {
         return 0;
      } else {
         int result = T_GRequestRepository.insertGrequest(grequest);
         return 1;
      }

   }

   @ResponseBody
   @RequestMapping(value = "/groupMemberDelete", method = RequestMethod.POST)
   public int groupMemberDelete(@RequestBody T_Grequest grequest, HttpSession session) {
      System.out.println("qwwww" + grequest);
      T_Group group = new T_Group();
      group.setGroNum(grequest.getGroNum());
      String userId = (String) session.getAttribute("loginId");
      grequest.setgRequester(userId);
      System.out.println("22qwwww" + grequest);
      int result = T_GRequestRepository.groupMemberDelete(grequest);
      T_GroupRepository.miusUserCount(group);
      return result;
   }
}