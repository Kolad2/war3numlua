function Set()
    local self = List()
    meta = getmetatable(self)
    setmetatable(self, {})
    
    local index_table = {}
    local super_append = self.append

    function self.append(elem)
        if index_table[elem] then
            print("Ошибка: элемент уже существовал")
            return false
        end
        index_table[elem] = self.len
        super_append(elem)
        return true
    end
    self.add = self.append
    
    local super_pop_swap = self.pop_swap
    function self.pop_swap(idx)
        local item = super_pop_swap(idx)
        if item~=nil then
            if self[idx]~=nil then index_table[self[idx]] = idx end
            index_table[item] = nil
            return true
        end
        return false
    end
    
    function self.remove(elem)
        local idx = index_table[elem]
        if not idx then
            print("Ошибка: элемент не существовал")
            return false
        end
        return self.pop_swap(idx)
    end
    
    if DEBUG_MODE then
        debug_tools(self, meta)
    end
    
    print("Set() inited")
    return setmetatable(self, meta)
end
