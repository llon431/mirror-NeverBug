package com.bag2bag.st.controller;

import com.bag2bag.st.services.ItemsService;
import com.bag2bag.st.vo.Result;
import org.springframework.web.bind.annotation.*;
import com.bag2bag.st.entity.Item;
import javax.annotation.Resource;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import com.bag2bag.st.vo.R;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/items")
public class ItemsController {

    @Resource(type = ItemsService.class)
    private ItemsService itemsService;

    @GetMapping("/homepage")
    public Result<Map<String,Object>> homepage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int pageSize) {

        List<Item> items = itemsService.homepage(page, pageSize);
        int total = itemsService.countActive();

        Map<String, Object> payload = new HashMap<>();
        payload.put("items", items);
        payload.put("total", total);
        payload.put("page", page);
        payload.put("pageSize", pageSize);
        return Result.ok(payload);
    }

}
