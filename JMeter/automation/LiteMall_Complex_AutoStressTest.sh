#!/usr/bin/env bash

# 压测脚本模板中设定的压测时间应为20秒
export jmx_template="LiteMall_Complex_Auto"
export suffix=".jmx"
export jmx_template_filename="${jmx_template}${suffix}"
export os_type=`uname`
#export duration_time=60

# 需要在系统变量中定义jmeter根目录的位置，如下
# export jmeter_path="/your jmeter path/"

echo "自动化压测开始"
rm -rf web-report
mkdir -p web-report
echo "" > web-report/index.html

# 压测并发数列表
thread_number_array=(${thread_array})
for thread_num in "${thread_number_array[@]}"
do
    # 生成对应压测线程的jmx文件
    export cur_time=`date "+%H:%M:%S"`
    export jmx_filename="${jmx_template}_${thread_num}_run@${cur_time}${suffix}"
    export jtl_filename="test_${thread_num}_run@${cur_time}.jtl"
    export web_report_path_name="web_${thread_num}_run@${cur_time}"


    rm -f ${jmx_filename} ${jtl_filename}

    cp ${jmx_template_filename} ${jmx_filename}
    echo "生成jmx压测脚本 ${jmx_filename}"

    if [[ "${os_type}" == "Darwin" ]]; then
        sed -i "" "s/thread_num/${thread_num}/g" ${jmx_filename}
        sed -i "" "s/duration_time/${duration_time}/g" ${jmx_filename}
    else
        sed -i "s/thread_num/${thread_num}/g" ${jmx_filename}
        sed -i "s/duration_time/${duration_time}/g" ${jmx_filename}
    fi

    # JMeter 静默压测
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename}
    echo "压测完毕 ${jmx_filename}"

    # 生成Web压测报告
    ${jmeter_path}/bin/jmeter -g ${jtl_filename} -e -o web-report/${web_report_path_name}
    echo "<a href='${web_report_path_name}'>${web_report_path_name}</a><br><br>" >> web-report/index.html
    echo "生成报告${web_report_path_name}完毕"

#    rm -f ${jmx_filename} ${jtl_filename}
    sleep ${sleep_sec_bw}
done
echo "自动化压测全部结束"
