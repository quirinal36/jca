package www.jca.com.web;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.jca.com.service.BoardService;
import www.jca.com.service.FileInfoService;
import www.jca.com.service.MenuService;
import www.jca.com.service.PhotoInfoService;
import www.jca.com.util.FileUtil;
import www.jca.com.vo.Board;
import www.jca.com.vo.FileInfo;
import www.jca.com.vo.Menus;
import www.jca.com.vo.PhotoInfo;
import www.jca.com.vo.UserVO;

@RequestMapping("/board")
@Controller
public class NoticeController extends JCAController implements BoardController<Board>{
	// final int BOARD_TYPE = 1;
	
	@Autowired
	BoardService service;
	@Autowired
	FileInfoService fileInfoService;
	@Autowired
	PhotoInfoService photoInfoService;
	@Autowired
	MenuService menuService;
	
	@Override
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView getListView(ModelAndView mv, Board model) {
		model.setBoardType(0);
		
		int count = service.count(model);
		model.setTotalCount(count);
		
		List<Board> boardList = service.select(model);
		mv.addObject("list", boardList);
		
		mv.setViewName("/notice/list");
		return mv;
	}
	
	@RequestMapping(value="/type/{boardType}", method=RequestMethod.GET)
	public ModelAndView getListView(ModelAndView mv, Board model,
			@PathVariable(value="boardType")Integer typeOfBoard) {
		model.setBoardType(typeOfBoard);
		
		Menus menu = menuService.selectOne(Menus.newInstance(model.getBoardType()));
		
		mv.addObject("listUrl", "/board/type/"+typeOfBoard);
		mv.addObject("menu", menu);
		
		if(typeOfBoard == 5) {
			mv.setViewName("/contents/curriculum");
		}else {
			int count = service.count(model);
			model.setTotalCount(count);
			
			List<Board> boardList = service.select(model);
			mv.addObject("list", boardList);	
			mv.addObject("paging", model);
			mv.setViewName("/notice/list");
		}
		return mv;
	}
	@Override	
	@RequestMapping(value="/view", method = RequestMethod.GET)
	public ModelAndView getDetailView(ModelAndView mv, Board model) {
		Board board = service.selectOne(model);
		
		FileInfo input = new FileInfo();
		input.setBoardId(board.getId());
		List<FileInfo> files = fileInfoService.select(input);
		
		PhotoInfo photo = new PhotoInfo();
		photo.setBoardId(board.getId());
		List<PhotoInfo> photos = photoInfoService.select(photo);
		
		Menus menu = menuService.selectOne(Menus.newInstance(board.getBoardType()));
		
		mv.addObject("photos", photos);
		mv.addObject("files", files);
		mv.addObject("board", board);
		mv.addObject("menu", menu);
		mv.addObject("listUrl", "/board/type/"+board.getBoardType());
		mv.setViewName("/notice/view");
		return mv;
	}

	@Override
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv, Board model, HttpServletRequest request) {
		if(request.isUserInRole("ROLE_ADMIN")) {
			Board board = service.selectOne(model);
			
			List<Menus> menus = menuService.selectChildren();
			Menus menu = menuService.selectOne(Menus.newInstance(board.getBoardType()));
			
			mv.addObject("boardTypes", menus);
			mv.addObject("menu", menu);
			mv.addObject("board", board);
			mv.setViewName("/notice/edit");
		}else {
			mv.setViewName("redirect:/");
		}
		return mv;
	}
	
	@Override
	@RequestMapping(value="/{boardType}/write", method = RequestMethod.GET)
	public ModelAndView getWriteView(ModelAndView mv, Board model, HttpServletRequest request,
			@PathVariable(value="boardType")Integer typeOfBoard) {
		
		if(request.isUserInRole("ROLE_ADMIN")) {
			List<Menus> menus = menuService.selectChildren();
			Iterator<Menus> iter = menus.iterator();
			while(iter.hasNext()) {
				Menus menu = iter.next();
				if(menu.getId() == typeOfBoard) {
					mv.addObject("menu", menu);
				}
			}
			
			mv.addObject("boardType", typeOfBoard);
			mv.addObject("boardTypes", menus);
			mv.setViewName("/notice/write");
		}else {
			mv.setViewName("redirect:/board/type/"+typeOfBoard);
		}
		return mv;
	}
	
	@Override
	@ResponseBody
	@RequestMapping(value="/{name}/deprecated", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String write(Board model) {
		JSONObject json = new JSONObject();
		UserVO user = getUser();
		if(user != null) {
			model.setWriter(user.getId());
		}
		
		int result = service.insert(model);
		json.put("result", result);
		
		return json.toString();
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public ModelAndView writeWithAttach(Board model, 
			@RequestParam(value="files", required = false)String files,
			@RequestParam(value="images", required = false)String images,
			ModelAndView mv) {
		
		JSONObject json = new JSONObject();
		UserVO user = getUser();
		if(user != null) {
			model.setWriter(user.getId());
		}
		
		int result = service.insert(model);
		json.put("result", result);
		
		if(files !=null && files.length() > 0) {
			FileUtil fileUtil = new FileUtil();
			fileInfoService.update(fileUtil.parseFileInfo(files.split(","), model.getId()));
		}
		if(images !=null && images.length() > 0) {
			FileUtil fileUtil = new FileUtil();
			photoInfoService.update(fileUtil.parsePhotoInfo(images.split(","), model.getId()));
		}
		
		mv.setViewName("redirect:/board/type/"+model.getBoardType());
		return mv;
	}
	
	@Override
	public ModelAndView edit(Board model, ModelAndView mv) {
		
		JSONObject json = new JSONObject();
		int result = service.update(model);
		json.put("result", result);
		
		mv.setViewName("redirect:/board/type/"+model.getBoardType());
		return mv;
	}
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public ModelAndView edit(Board model, ModelAndView mv, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(request.isUserInRole("ROLE_ADMIN")) {
			int result = service.update(model);
			json.put("result", result);
			mv.setViewName("redirect:/board/type/"+model.getBoardType());
		}else {
			json.put("result", -1);
		}
		return mv;
	}
	@Override
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(Board model) {
		JSONObject json = new JSONObject();
		
		int result = service.delete(model);
		json.put("result", result);
		return json.toString();
	}
}
