.pragma library

function filter(tasks, filter, name) {
    //print("Running filter:", name)
    var list = []

    for (var i = 0; i < length(tasks); i++) {
        var task = getItem(tasks, i)
        //print("Filtering:", task.name)
        if (filter(task))
            list.push(task)
    }

    //print("Filtered list:", list)

    return list
}

function filteredCount(model, func, name) {
    return filter(model, func, name).length
}

function iter(list, func) {
    var value = 0

    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        var ans = func(item)
        value += ans
    }

    return value
}

function filteredSum(list, prop, func, name) {
    var value = 0

    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        value += filteredCount(item[prop], func, name)
    }

    return value
}

function sum(list, prop) {
    var value = 0

    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        value += item[prop]
    }

    return value
}

function subList(list, prop) {
    var value = []

    //print("Concat:", prop, length(list))

    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        value.push(item[prop])
    }

    //print("Concat:", prop, value, length(value))
    return value
}

function toList(model) {
    var list = []

    for (var i = 0; i < model.count; i++) {
        list.push(getItem(model, i))
    }

    return list
}

function sort(list, prop) {
    if (list.hasOwnProperty("count"))
        list = toList(list)
    //print("Sorting by", prop)
    list.sort(function(a, b) {
        return b.relevence - a.relevence
    });

    return list
}

function concat(list, prop, filter) {
    var value = []

    //print("Concat:", prop, length(list))

    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        if (filter && !filter(item)) continue

        //print("Adding:", item[prop])
        if (item[prop].hasOwnProperty("length")) {
            value = value.concat(item[prop])
        } else {
            for (var j = 0; j < item[prop].count; j++) {
                value.push(getItem(item[prop], j))
            }
        }
    }

    //print("Concat:", prop, value, length(value))
    return value
}

function getItem(model, index) {
    var item = model.hasOwnProperty("get") ? model.get(index) : model[index]
    if (model.hasOwnProperty("get"))
        item = item.modelData

    return item
}

function getItemByFilter(list, filter) {
    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        if (filter(item))
            return item
    }

    return null
}

function length(model) {
    if (model === undefined || model === null)
        return 0
    else
        return model.hasOwnProperty("count") ? model.count : model.length
}

function objectKeys(obj) {
    var keys = []
    for(var k in obj)
        keys.push(k)
    return keys
}
