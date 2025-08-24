#!/bin/bash

# 修复图片路径的脚本
echo "开始修复图片路径..."

# 处理每个课程目录
for i in {0..18}; do
    lesson_dir="content/docs/lesson$(printf "%02d" $i)"
    if [ -d "$lesson_dir" ]; then
        echo "Processing $lesson_dir"
        
        # 查找该目录下的 markdown 文件
        for md_file in "$lesson_dir"/*.md; do
            if [ -f "$md_file" ]; then
                lesson_num="lesson$(printf "%02d" $i)"
                
                # 创建临时文件
                temp_file=$(mktemp)
                
                # 修复相对路径的图片引用
                # ./images/ -> /images/lesson00/
                # ./img/ -> /images/lesson04-img/ (对于有img目录的课程)
                
                if [ "$lesson_num" == "lesson04" ] || [ "$lesson_num" == "lesson17" ]; then
                    # 这些课程使用 img 目录
                    sed "s|\\./img/|/images/${lesson_num}-img/|g" "$md_file" > "$temp_file"
                else
                    # 其他课程使用 images 目录
                    sed "s|\\./images/|/images/${lesson_num}/|g" "$md_file" > "$temp_file"
                fi
                
                # 替换原文件
                mv "$temp_file" "$md_file"
                
                echo "Updated image paths in $md_file"
                break  # 只处理第一个 md 文件
            fi
        done
    fi
done

echo "图片路径修复完成!"