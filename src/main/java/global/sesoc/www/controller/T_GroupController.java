package global.sesoc.www.controller;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.www.dao.T_BoardRepository;
import global.sesoc.www.dao.T_GrequestRepository;
import global.sesoc.www.dao.T_GroupRepository;
import global.sesoc.www.dao.T_ReplyRepository;
import global.sesoc.www.dto.T_Board;
import global.sesoc.www.dto.T_Grequest;
import global.sesoc.www.dto.T_Group;
import global.sesoc.www.util.FileService;

@Controller
public class T_GroupController {
   @Autowired
   T_GroupRepository T_GroupRepository; 
   @Autowired
   T_BoardRepository T_BoardRepository;
   @Autowired
   T_GrequestRepository T_GrequestRepository;
   @Autowired
   T_ReplyRepository T_ReplyRepository;
   final String uploadPath="/uploadPath";
   
   @RequestMapping(value="/groupList", method=RequestMethod.GET)
   public String groupList(Model model,HttpSession session) {
      String loginId=(String)session.getAttribute("loginId");
      List<Integer> aList=T_GroupRepository.checkApplyGroup(loginId);
      List<T_Group> list=T_GroupRepository.selectAllGroup();
      List<Integer> applyList=new ArrayList<Integer>();
      List<Integer> groNum=new ArrayList<>();
      for (int i = 0; i < list.size(); i++) {
         for (int j = 0; j < aList.size(); j++) {
            if (list.get(i).getGroNum()==aList.get(j)) {
               applyList.add(aList.get(j));
            }
            
         }
         if(list.get(i).getUserId().equals(loginId)) {
            applyList.add(list.get(i).getGroNum());
         }
      }
      for (int i = 0; i < list.size(); i++) {
         groNum.add(list.get(i).getGroNum());
      }
      System.out.println("list="+list);
      System.out.println("aList="+aList);
      System.out.println("122"+applyList);
      model.addAttribute("groNums",groNum);
      model.addAttribute("applyList",applyList);
      model.addAttribute("group",list);
      
      return "group/groupList";
   }
   
   @RequestMapping(value="/myGroupList", method=RequestMethod.GET)
   public String myGroupList(Model model,HttpSession session) {
      String userId=(String)session.getAttribute("loginId");
      T_Group g = new T_Group();    g.setUserId(userId);
      List<T_Group> list=T_GroupRepository.selectMyGroupList(g);
      List<Integer> applyList=T_GroupRepository.checkApplyGroup(userId);
      model.addAttribute("group",list);
      model.addAttribute("applyList",applyList);
      return "group/myGroupList";
   }
   
   @RequestMapping(value="/insertGroup", method=RequestMethod.GET)
   public String insertGroup() {
      return "group/insertGroup";
   }
   @RequestMapping(value="/insertGroup", method=RequestMethod.POST)
   public String insertGroup(HttpSession session,T_Group group, MultipartFile upload, Model model) {
      System.out.println("업로드 여부 : "+upload+", 파일의 크기 : "+upload.getSize()+", 파일의 여부 : "+!(upload.isEmpty()));
      if(!upload.isEmpty()) {
      String savedFile=FileService.saveFile(upload, uploadPath);
      String OrigialFile=upload.getOriginalFilename();
      group.setOriginalImage(OrigialFile);
      group.setSavedImage(savedFile);   
      }
      
      String userId=(String)session.getAttribute("loginId");
      group.setUserId(userId);
      System.out.println(group);
      int result=T_GroupRepository.insertGroup(group);
      
      List<T_Group> list=T_GroupRepository.selectAllGroup();
      model.addAttribute("group",list);
      if(result==1) {
         System.out.println("success!!");
      }
      return "redirect:groupList";
   }
   @RequestMapping(value="/groupDetail", method=RequestMethod.GET)
   public String groupDetail(T_Group group, Model model) {
   
      List<T_Board> bList=T_BoardRepository.selectGroNumBoard(group.getGroNum());
      T_Group g=T_GroupRepository.selectOneGroup(group);
      List<T_Grequest> userList=T_GrequestRepository.getGroupUsers(group.getGroNum());
      
      model.addAttribute("userList",userList);
      model.addAttribute("group",g);
      model.addAttribute("bList",bList);
      
      return "group/groupDetail";
   }
   @RequestMapping(value="/groupDownload", method=RequestMethod.GET)
   public String groupDownload(HttpSession session,T_Group t, HttpServletResponse response) {
        String userId = (String) session.getAttribute("loginId");
        //t.setUserId(userId);
        T_Group group = T_GroupRepository.selectOneGroup(t);
      
      String originalImage = group.getOriginalImage();
      String fullPath = uploadPath + "/" + group.getSavedImage();
      
      try {
         response.setHeader("Content-Disposition", " attachment;filename="+URLEncoder.encode(originalImage, "UTF-8")); //Content-Disposition: 어떤 종류의 파일이 전송되어간다를 알려줌.
         
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
      FileInputStream fin = null;
      ServletOutputStream fileout = null;
      
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
   @RequestMapping(value="/groupDelete", method=RequestMethod.GET)
   public String deleteGroup(T_Group group) {
      System.out.println("111111::"+group);
      T_ReplyRepository.deleteGroupReply(group.getGroNum());
      int groNum=group.getGroNum();
      int r=T_BoardRepository.deleteGroupBoard(groNum);
      System.out.println("2:"+r);
      int r2=T_GrequestRepository.deleteGroupGrequest(groNum);
      System.out.println("3:"+r2);
      int result=T_GroupRepository.deleteGroup(groNum);
      System.out.println("4:"+result);
      
      return "redirect:groupList";
   }
}