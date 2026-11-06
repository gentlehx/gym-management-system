window.addEventListener('DOMContentLoaded', function () {
    // Simple-DataTables（中文化）
    // https://github.com/fiduswriter/Simple-DataTables/wiki
    var datatablesSimple = document.getElementById('datatablesSimple');
    if (!datatablesSimple || typeof simpleDatatables === 'undefined') {
        return;
    }

    new simpleDatatables.DataTable(datatablesSimple, {
        perPage: 10,
        perPageSelect: [10, 25, 50, 100],
        labels: {
            placeholder: '搜索…',
            perPage: '条 / 页',
            noRows: '暂无数据',
            info: '第 {start} - {end} 条，共 {rows} 条',
            noResults: '没有匹配的记录'
        }
    });
});
