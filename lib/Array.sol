// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

library Array {
    function push(uint256[] memory _nums, uint256 _num) internal pure {
        assembly {
            mstore(add(_nums, mul(add(mload(_nums), 1), 0x20)), _num)
            mstore(_nums, add(mload(_nums), 1))
            // 0x40 是空闲内存指针的预定义位置 (value 为 空闲指针开始位)
            mstore(0x40, add(mload(0x40), 0x20))
        }
    }

    function pop(uint256[] memory _nums) internal pure returns (uint256 num_) {
        assembly {
            num_ := mload(add(_nums, mul(mload(_nums), 0x20)))
            mstore(_nums, sub(mload(_nums), 1))
        }
    }

    function del(uint256[] memory _nums, uint256 _index) internal pure {
        assembly {
            if lt(_index, mload(_nums)) {
                mstore(
                    add(_nums, mul(add(_index, 1), 0x20)),
                    mload(add(_nums, mul(mload(_nums), 0x20)))
                )
                mstore(_nums, sub(mload(_nums), 1))
            }
        }
    }

    function update(
        uint256[] memory _nums,
        uint256 _index,
        uint256 _num
    ) internal pure {
        _nums[_index] = _num;
    }

    function get(uint256[] memory _nums, uint256 _index)
        internal
        pure
        returns (uint256)
    {
        return _nums[_index];
    }
}

contract testArr {
    using Array for uint256[];

    function push(uint256[] memory _nums, uint256 num)
        external
        pure
        returns (uint256[] memory)
    {
        _nums.push(num);
        return _nums;
    }

    function pop(uint256[] memory _nums)
        external
        pure
        returns (uint256[] memory, uint256)
    {
        uint256 num_ = _nums.pop();
        return (_nums, num_);
    }

    function del(uint256[] memory _nums, uint256 _index)
        external
        pure
        returns (uint256[] memory)
    {
        _nums.del(_index);
        return _nums;
    }

    function update(
        uint256[] memory _nums,
        uint256 _index,
        uint256 _num
    ) external pure returns (uint256[] memory) {
        _nums.update(_index, _num);
        return _nums;
    }

    function get(uint256[] memory _nums, uint256 _index)
        external
        pure
        returns (uint256)
    {
        return _nums.get(_index);
    }
}
