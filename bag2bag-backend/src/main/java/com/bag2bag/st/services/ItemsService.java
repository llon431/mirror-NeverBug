package com.bag2bag.st.services;

import com.bag2bag.st.entity.Item;
import java.util.List;

public interface ItemsService {

    /** 首頁：取已上架(active)商品，含分頁 */
    List<Item> homepage(int page, int pageSize);

    /** 首頁：已上架商品總數 */
    int countActive();

}
