#!/bin/bash

#==================================================
#   أداة كشف الثغرات الشاملة - من تطوير: AL-F
#--------------------------------------------------
#   Snapchat : LSLF
#   Instagram: LSLF_6
#==================================================

read -p "أدخل رابط الموقع (مثال: http://example.com): " TARGET

DOMAIN=$(echo "$TARGET" | awk -F[/:] '{print $4}')

echo "=================================================="
echo "        فحص شامل لأغلب ثغرات المواقع"
echo "               - AL-F -"
echo "   Snapchat : LSLF | Instagram : LSLF_6"
echo "=================================================="
echo "[*] فحص الموقع: $TARGET"
echo "[*] النطاق: $DOMAIN"
echo

echo "--------------------------------------------------"
echo "[+] WhatWeb - تقنيات الموقع"
whatweb "$TARGET"
echo

echo "--------------------------------------------------"
echo "[+] Nmap - فحص المنافذ والخدمات"
nmap -sV -T4 "$DOMAIN"
echo

echo "--------------------------------------------------"
echo "[+] Nikto - فحص السيرفر والروابط"
nikto -h "$TARGET"
echo

echo "--------------------------------------------------"
read -p "[?] هل تريد تجربة SQLi؟ (y/n): " SQLI_CONFIRM
if [ "$SQLI_CONFIRM" = "y" ]; then
    read -p "أدخل رابط يحتوي على باراميتر (مثال: http://example.com/item.php?id=1): " SQLI_URL
    sqlmap -u "$SQLI_URL" --batch --level=2 --risk=2
fi

if command -v xsstrike &> /dev/null; then
    echo "--------------------------------------------------"
    read -p "[?] هل تريد فحص XSS؟ (y/n): " XSS_CONFIRM
    if [ "$XSS_CONFIRM" = "y" ]; then
        xsstrike --crawl --basic --url "$TARGET"
    fi
else
    echo "[!] أداة xsstrike غير مثبتة. تخطّي فحص XSS."
fi

echo "=================================================="
echo "[*] تم الانتهاء من الفحص بواسطة AL-F"
echo "    Snapchat : LSLF | Instagram : LSLF_6"
