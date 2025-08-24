#!/bin/bash

# 课程标题映射
declare -A titles=(
    ["lesson00"]="从 0 开始学 Go"
    ["lesson01"]="基础语法"
    ["lesson02"]="数组和切片"
    ["lesson03"]="包、指针、结构体和接口"
    ["lesson04"]="后端 Go 第四次课"
    ["lesson05"]="并发编程"
    ["lesson06"]="HTTP 服务简单案例"
    ["lesson07"]="MySQL 数据库"
    ["lesson08"]="Redis 和 MongoDB"
    ["lesson09"]="第九课"
    ["lesson10"]="Docker 容器化"
    ["lesson11"]="单体架构实战"
    ["lesson12"]="第十二课"
    ["lesson13"]="微服务入门"
    ["lesson14"]="Go-zero 微服务"
    ["lesson15"]="第十五课"
    ["lesson16"]="负载均衡"
    ["lesson17"]="第十七课"
    ["lesson18"]="第十八课"
)

# 处理每个课程目录
for i in {0..18}; do
    lesson_dir="content/docs/lesson$(printf "%02d" $i)"
    if [ -d "$lesson_dir" ]; then
        echo "Processing $lesson_dir"
        
        # 查找该目录下的 markdown 文件
        for md_file in "$lesson_dir"/*.md; do
            if [ -f "$md_file" ]; then
                filename=$(basename "$md_file")
                lesson_num="lesson$(printf "%02d" $i)"
                title="${titles[$lesson_num]}"
                weight=$((i + 1))
                
                # 创建临时文件
                temp_file=$(mktemp)
                
                # 添加 front matter
                cat > "$temp_file" << EOF
---
title: "$title"
linkTitle: "第${i}课"
weight: $weight
description: >
  $title
---

EOF
                
                # 添加原文件内容
                cat "$md_file" >> "$temp_file"
                
                # 替换原文件
                mv "$temp_file" "$md_file"
                
                echo "Updated $md_file"
                break  # 只处理第一个 md 文件
            fi
        done
    fi
done

echo "Front matter added to all lesson files!"