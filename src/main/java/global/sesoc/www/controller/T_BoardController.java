package global.sesoc.www.controller;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.www.dao.T_BoardRepository;
import global.sesoc.www.dao.T_GroupRepository;
import global.sesoc.www.dao.T_ReplyRepository;
import global.sesoc.www.dto.T_Board;
import global.sesoc.www.dto.T_Group;
import global.sesoc.www.dto.T_Reply;
import global.sesoc.www.util.FileService;

@Controller
public class T_BoardController {
   @Autowired
   T_BoardRepository T_BoardRepository;
   @Autowired
   T_GroupRepository T_GroupRepository;
   @Autowired
   T_ReplyRepository T_ReplyRepository; 
   final String uploadPath="/uploadPath";
   @RequestMapping(value="/insertBoard",method=RequestMethod.GET)
   public String insertBoard(T_Board board,Model model) {
      model.addAttribute("groNum",board.getGroNum());
      return "board/insertBoard";         
   }
   @RequestMapping(value="/insertBoard",method=RequestMethod.POST)
   public String insertBoard(Model model,T_Board board,HttpSession session,MultipartFile upload) {
      
      System.out.println("업로드 여부 : "+upload+", 파일의 크기 : "+upload.getSize()+", 파일의 여부 : "+!(upload.isEmpty()));
      if(!upload.isEmpty()) {
      String savedFile=FileService.saveFile(upload, uploadPath);
      String OrigialFile=upload.getOriginalFilename();
      board.setOriginalFile(OrigialFile);
      board.setSavedFile(savedFile);   
      }
      
      String userId=(String)session.getAttribute("loginId");
      board.setUserId(userId);
      
      
      int result=T_BoardRepository.insertBoard(board);
      
      
      T_Group group=new T_Group(); group.setGroNum(board.getGroNum());
      List<T_Board> bList=T_BoardRepository.selectGroNumBoard(board.getGroNum());
      T_Group g=T_GroupRepository.selectOneGroup(group);
      
      model.addAttribute("group",g);
      model.addAttribute("bList",bList);
      return "group/groupDetail";
   }
   @ResponseBody
   @RequestMapping(value="/deleteBoard",method=RequestMethod.POST)
   public int deleteBoard(@RequestBody T_Board board) {
      System.out.println(board);
      T_ReplyRepository.deleteBoardReply(board.getBoaNum());
      int result=T_BoardRepository.deleteBoard(board.getBoaNum());
      return result;
   }
   
   @RequestMapping(value="/boardDownload", method=RequestMethod.GET)
   public String groupDownload(HttpSession session,T_Board t, HttpServletResponse response) {
        String userId = (String) session.getAttribute("loginId");
        t.setUserId(userId);
        
        T_Board board = T_BoardRepository.detailBoard(t);
      
      String originalImage = board.getOriginalFile();
      String fullPath = uploadPath + "/" + board.getSavedFile();
      
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

}