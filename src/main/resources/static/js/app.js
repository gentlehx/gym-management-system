/* 全局交互增强：菜单高亮、提示自动消失、图表统一样式 */
(function () {
    'use strict';

    // 1. 侧边栏当前页高亮
    var path = window.location.pathname;
    var links = document.querySelectorAll('.sb-sidenav .nav-link');
    var best = null;
    var bestLen = -1;
    Array.prototype.forEach.call(links, function (a) {
        var href = a.getAttribute('href') || '';
        if (!href || href === '#' || href.indexOf('javascript') >= 0) return;
        var target;
        try {
            target = new URL(href, window.location.origin).pathname;
        } catch (e) {
            return;
        }
        if (target === '/' ) return;
        if (path === target || path.indexOf(target + '/') === 0 || path.indexOf(target + '?') === 0) {
            if (target.length > bestLen) {
                best = a;
                bestLen = target.length;
            }
        }
    });
    if (best) {
        best.classList.add('active');
        // 展开父级折叠菜单
        var parent = best.closest('.collapse');
        if (parent && window.bootstrap) {
            new bootstrap.Collapse(parent, {toggle: false}).show();
        }
    }

    // 2. 成功/提示类消息 5 秒后淡出
    Array.prototype.forEach.call(document.querySelectorAll('.alert-success, .alert-info'), function (el) {
        if (!el.classList.contains('alert-dismissible')) return;
        window.setTimeout(function () {
            el.style.transition = 'opacity .4s ease, transform .4s ease';
            el.style.opacity = '0';
            el.style.transform = 'translateY(-6px)';
            window.setTimeout(function () {
                if (el.parentNode) el.parentNode.removeChild(el);
            }, 420);
        }, 5000);
    });

    // 3. Chart.js 全局字体
    if (window.Chart && Chart.defaults && Chart.defaults.global) {
        Chart.defaults.global.defaultFontFamily = '-apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang SC", "Microsoft YaHei", sans-serif';
        Chart.defaults.global.defaultFontSize = 11;
        Chart.defaults.global.defaultFontColor = '#64748b';
    }

    // 4. 轻量 Toast（需要时调用 window.toast('内容','success')）
    window.toast = function (message, type) {
        var box = document.getElementById('toastBox');
        if (!box) {
            box = document.createElement('div');
            box.id = 'toastBox';
            box.style.cssText = 'position:fixed;top:78px;right:24px;z-index:2000;display:flex;flex-direction:column;gap:8px';
            document.body.appendChild(box);
        }
        var colors = {
            success: ['#ecfdf5', '#047857', '#bbf7d0'],
            error: ['#fef2f2', '#b91c1c', '#fecaca'],
            info: ['#f0f9ff', '#0369a1', '#bae6fd']
        };
        var c = colors[type] || colors.info;
        var item = document.createElement('div');
        item.textContent = message;
        item.style.cssText = 'background:' + c[0] + ';color:' + c[1] + ';border:1px solid ' + c[2] +
            ';padding:10px 16px;border-radius:12px;font-size:13px;box-shadow:0 12px 28px -16px rgba(15,23,42,.45);' +
            'opacity:0;transform:translateX(12px);transition:all .25s ease';
        box.appendChild(item);
        window.requestAnimationFrame(function () {
            item.style.opacity = '1';
            item.style.transform = 'translateX(0)';
        });
        window.setTimeout(function () {
            item.style.opacity = '0';
            item.style.transform = 'translateX(12px)';
            window.setTimeout(function () {
                if (item.parentNode) item.parentNode.removeChild(item);
            }, 260);
        }, 2800);
    };
})();
