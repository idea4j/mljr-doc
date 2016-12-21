#修复库存不正确的数据
UPDATE m_spike_commodity
SET stock = real_stock;

