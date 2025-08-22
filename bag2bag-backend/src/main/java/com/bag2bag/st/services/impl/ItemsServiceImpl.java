package com.bag2bag.st.services.impl;

import com.bag2bag.st.entity.Item;
import com.bag2bag.st.mapper.ItemMapper;
import com.bag2bag.st.services.ItemsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service
public class ItemsServiceImpl implements ItemsService {

    @Resource
    private ItemMapper itemMapper;

    @Override
    public List<Item> homepage(int page, int pageSize) {
        int safePage = Math.max(page, 1);
        int safeSize = Math.max(pageSize, 1);
        int offset = (safePage - 1) * safeSize;
        List<Item> list = itemMapper.selectActiveForHomepage(offset, pageSize);
        return itemMapper.selectActiveForHomepage(offset, safeSize);
    }

    @Override
    public int countActive() {
        return itemMapper.countActive();
    }

}
