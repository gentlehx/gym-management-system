package com.milotnt.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 演示用业务时钟。
 * <p>
 * 工程演示数据统一落在 2025 年 10 月上旬，因此新增记录的“日期”一律取这里定义的
 * 业务基准日，避免出现 2026 年的日期而破坏数据的一致性；时刻仍取真实时间。
 *
 * @author MiloTnT
 */
public final class BusinessClock {

    //业务基准日（与演示数据保持一致）
    public static final String BUSINESS_DATE = "2025-10-10";

    private BusinessClock() {
    }

    //当前时刻 HH:mm
    public static String currentTime() {
        return new SimpleDateFormat("HH:mm").format(new Date());
    }

    //业务日期 + 当前时刻
    public static String currentDateTime() {
        return BUSINESS_DATE + " " + new SimpleDateFormat("HH:mm:ss").format(new Date());
    }
}
