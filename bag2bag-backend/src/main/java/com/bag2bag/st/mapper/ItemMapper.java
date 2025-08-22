package com.bag2bag.st.mapper;

import com.bag2bag.st.entity.Item;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ItemMapper {
    List<Item> selectActiveForHomepage(@Param("offset") int offset,
                                       @Param("pageSize") int pageSize);
    int countActive();

    // 如果你還需要「全部」：
    List<Item> getAllItem();
}