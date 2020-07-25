package www.jca.com.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import www.jca.com.service.BoardService;
import www.jca.com.vo.Board;

@RestController
public class BoardRestController extends JCAController {
	@Autowired
	BoardService service;
	
	/**
	 * 게시판 종류를 선택하면 리스트를 돌려준다.
	 * 
	 * @param typeOfBoard : 메뉴번호
	 * @param pageNum : 페이지 번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= {"/api/board/list/{boardType}/{page}","/api/board/list/{boardType}"}, method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, List> getBoardList(@PathVariable(value="boardType")Optional<Integer> typeOfBoard,
			@PathVariable(value="page")Optional<Integer>pageNum, Board board) {
		logger.info(board.toString());
		
		if(typeOfBoard.isPresent()) {
			board.setBoardType(typeOfBoard.get());
		}else {
			board.setBoardType(7);
		}
		if(pageNum.isPresent()) {
			board.setPageNo(pageNum.get());
		}else {
			board.setPageNo(1);
		}
		
		int count = service.count(board);
		board.setTotalCount(count);
		
		List<Board> boardList = service.select(board);
		Map<String, List> result = new HashMap<String, List>();
		result.put("list", boardList);
		
		return result;
	}
	
	/**
	 * 게시판 페이징을 위한 객체
	 * 
	 * @param typeOfBoard
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= {"/api/board/count/{boardType}","/api/board/count/{boardType}/{pageNo}"}, method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Board>  getBoardListCount(@PathVariable(value="boardType")Integer typeOfBoard,
			@PathVariable(value="pageNo")Optional<Integer> pageNo, Board board){
		board.setBoardType(typeOfBoard);
		int count = service.count(board);
		board.setTotalCount(count);
		if(pageNo.isPresent()) {
			board.setPageNo(pageNo.get());
		}else {
			board.setPageNo(1);
		}
		
		HttpHeaders headers = new HttpHeaders();
		ResponseEntity<Board> responseEntity = new ResponseEntity<Board>(board, headers, HttpStatus.OK);
		return responseEntity;
	}
	/**
	 * 게시글 디테일뷰를 위한 정보
	 * 
	 * @param boardId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= {"/api/board/detail/{boardId}"}, method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Board> getBoardDetail(@PathVariable(value="boardId")Integer boardId) {
		Map<String, Board> result = new HashMap<String, Board>();
		Board board = service.selectOne(Board.newInstance(boardId));
		
		result.put("board", board);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/api/board/write/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public String writeBoard(@RequestBody Board board){
		JSONObject json = new JSONObject();
		
		int result = service.insert(board);
		
		json.put("result", result);
		json.put("id", board.getId());
		json.put("boardType", board.getBoardType());
		
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/api/board/delete/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public String deleteBoard(@RequestBody Board board) {
		JSONObject json = new JSONObject();
		
		board = service.selectOne(board);
		json.put("result", service.delete(board));
		json.put("boardType", board.getBoardType());
		
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/api/board/edit/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public String editBoard(@RequestBody Board board) {
		JSONObject json = new JSONObject();
		Board origin = service.selectOne(board);
		json.put("result", service.update(board));
		json.put("boardType", origin.getBoardType());
		json.put("id", board.getId());
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/api/board/upload", method = RequestMethod.POST)
	public String uploadFile(@RequestParam MultipartFile file) {
		File newFile = new File("jjj.png");
		logger.info(newFile.getAbsolutePath());
		try {
			file.transferTo(newFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		JSONObject json = new JSONObject();
		json.put("result", 1);
		return json.toString();
	}
}
