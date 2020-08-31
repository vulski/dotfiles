#!/usr/bin/env python
## barbell weight calculator
## just for fun..

BAR = 45


tree = {
     45: 1,
     35: 2,
     25: 1,
     10: 2,
      5: 3,
    2.5: 1,
}

def get_total():
    total = BAR
    for weight in tree:
        total += weight * tree[weight] * 2
    return total

def get_plates(target):
    plates = {} # {45: 1, 5: 2}
    total = BAR
    max_weight = get_total()

    if target <= 0:
        raise SystemExit

    if target > max_weight:
        print("CAN'T GO THAT HIGH")
        raise SystemExit

    # all good, let's stack some plates
    total = BAR
    for w in sorted(tree.keys(), reverse=True): # start with heaviest weights first
        if total == target: # we're done
            break

        for _ in range(tree[w]):
            if total + (2 * w) <= target:
                total += 2*w
                if w in plates:
                    plates[w] += 1
                else:
                    plates[w] = 1

    return plates


if __name__ == '__main__':
    import sys

    try:
        target = int(sys.argv[1])
    except Exception as e:
        print(e)
        raise SystemExit

    plates = get_plates(target)

    total = BAR
    for p in plates:
        total += 2 * plates[p] * p
    print('total: {}'.format(total))

    for k in sorted(plates.keys(), reverse=True):
        print('{}: {}'.format(k, plates[k]))
