/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ogani.controller;

import java.util.List;
import ogani.entity.Comment;
import ogani.model.CommentModel;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Bang-GoD
 */
@Controller
@RequestMapping(value = "/adminComment")
public class AdminComment {

    private CommentModel commentModel;

    public AdminComment() {
        commentModel = new CommentModel();
    }

    @RequestMapping("View")
    public ModelAndView view() {
        ModelAndView mav = new ModelAndView("admin/comment");
        int countCommentTrue = commentModel.countCommentByTrue();
        mav.addObject("countCommentTrue", countCommentTrue);
        int countCommentFalse = commentModel.countCommentByFalse();
        mav.addObject("countCommentFalse", countCommentFalse);
        return mav;
    }

    @RequestMapping(value = "/commentTrue")
    public ModelAndView viewComment(@RequestParam(value = "pageCommentTrue", required = false) Integer pageCommentTrue,
            @RequestParam(value = "commentId", required = false) Integer commentId) {
        if (commentId != null) {
            boolean checkk = commentModel.deleteComment(commentId);
        }
        ModelAndView mav = new ModelAndView("admin/Ajax/commentTrue");
        List<Comment> list = commentModel.getAllCommentByTrue();
        PagedListHolder<Comment> listTrue = new PagedListHolder<>(list);
        listTrue.setPageSize(4);
        mav.addObject("maxTrue", listTrue.getPageCount());
        if (pageCommentTrue == null || pageCommentTrue < 1 || pageCommentTrue > listTrue.getPageCount()) {
            pageCommentTrue = 1;
        }
        mav.addObject("pageCommentTrue", pageCommentTrue);
        if (pageCommentTrue == null || pageCommentTrue < 1 || pageCommentTrue > listTrue.getPageCount()) {
            listTrue.setPage(0);
            mav.addObject("listCommentTrue", listTrue.getPageList());
        } else if (pageCommentTrue <= listTrue.getPageCount()) {
            listTrue.setPage(pageCommentTrue - 1);
            mav.addObject("listCommentTrue", listTrue.getPageList());
        }
        return mav;
    }

    @RequestMapping(value = "/commentFalse")
    public ModelAndView commentFalse(@RequestParam(value = "false_arr[]", required = false) Integer false_arr[],
            @RequestParam(value = "pageCommentFalse", required = false) Integer pageCommentFalse,
            @RequestParam(value = "commentId", required = false) Integer commentId) {
        if (false_arr != null) {
            for (Integer integer : false_arr) {
                Comment comment = commentModel.findByCommentId(integer);
                comment.setCommentStatus(true);
                boolean check = commentModel.updateComment(comment);
            }
        }
        if (commentId != null) {
            boolean checkk = commentModel.deleteComment(commentId);
        }
        ModelAndView mav = new ModelAndView("admin/Ajax/commentFalse");
        List<Comment> list = commentModel.getAllCommentByFalse();
        PagedListHolder<Comment> listFalse = new PagedListHolder<>(list);
        listFalse.setPageSize(4);
        mav.addObject("maxFalse", listFalse.getPageCount());
        if (pageCommentFalse == null || pageCommentFalse < 1) {
            pageCommentFalse = 1;
        } else if (pageCommentFalse > listFalse.getPageCount()) {
            pageCommentFalse = listFalse.getPageCount();
        }
        mav.addObject("pageCommentFalse", pageCommentFalse);
        if (pageCommentFalse == null || pageCommentFalse < 1 || pageCommentFalse > listFalse.getPageCount()) {
            listFalse.setPage(0);
            mav.addObject("listCommentFalse", listFalse.getPageList());
        } else if (pageCommentFalse <= listFalse.getPageCount()) {
            listFalse.setPage(pageCommentFalse - 1);
            mav.addObject("listCommentFalse", listFalse.getPageList());
        }
        return mav;
    }

    @RequestMapping(value = "loadUser")
    public @ResponseBody
    String loadUser(@RequestParam("commentId") Integer commentId) {
        Comment comment = commentModel.findByCommentId(commentId);
        if (comment == null) {
            return "Không Có";
        } else {
            return comment.getUsers().getUserName();
        }

    }

    @RequestMapping(value = "loadContent")
    public @ResponseBody
    String loadContent(@RequestParam("commentId") Integer commentId) {
        Comment comment = commentModel.findByCommentId(commentId);
        if (comment == null) {
            return "Không Có";
        } else {
            return comment.getContent();
        }

    }

}
