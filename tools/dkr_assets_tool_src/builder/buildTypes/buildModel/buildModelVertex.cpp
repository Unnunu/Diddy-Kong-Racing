#include "buildModelVertex.h"

#include "helpers/debugHelper.h"

using namespace DkrAssetsTool;

const Vec3f POSITION_ZERO = {};
const Vec4f COLOR_NULL = {};
const Vec4f COLOR_WHITE = { 1.0f };

BuildModelVertex::BuildModelVertex() : _position(POSITION_ZERO), _color(COLOR_NULL) {
}

BuildModelVertex::BuildModelVertex(const Vec3f position) : _position(position), _color(COLOR_WHITE) {
}

BuildModelVertex::BuildModelVertex(const Vec3f position, const Vec4f color) : _position(position), _color(color) {
}

BuildModelVertex::~BuildModelVertex() {
}

bool BuildModelVertex::operator==(const BuildModelVertex& other) const {
    return (_position == other._position) && (_color == other._color);
}

bool BuildModelVertex::operator!=(const BuildModelVertex& other) const {
    return !operator==(other);
}

Vec3f BuildModelVertex::position() const {
    return _position;
}

Vec4f BuildModelVertex::color() const {
    return _color;
}

bool BuildModelVertex::is_color_white() const {
    return _color == COLOR_WHITE;
}

void BuildModelVertex::write_to(DkrVertex *outVertex, float modelScale) {
    // Write position
    outVertex->x = static_cast<int16_t>(_position.x * modelScale);
    outVertex->y = static_cast<int16_t>(_position.y * modelScale);
    outVertex->z = static_cast<int16_t>(_position.z * modelScale);
    
    // Write color
    outVertex->r = _color.get_red_as_byte();
    outVertex->g = _color.get_green_as_byte();
    outVertex->b = _color.get_blue_as_byte();
    outVertex->a = _color.get_alpha_as_byte();
}

 std::ostream& operator<<(std::ostream& os, const BuildModelVertex& vertex) {
    os << "{ pos: " << vertex.position() << ", color: 0x" << std::hex << vertex.color().get_as_rgba() << std::dec << " }";
    return os;
}

void BuildModelVertex::add_morph_target(Vec3f newTarget) {
    if(!_targetPositions.has_value()) {
        _targetPositions = std::vector<Vec3f>();
    }
    _targetPositions.value().emplace_back(newTarget);
}

bool BuildModelVertex::has_targets() const {
    return _targetPositions.has_value();
}

bool BuildModelVertex::is_animated() const {
    if(!_targetPositions.has_value()) {
        return false;
    }
    const std::vector<Vec3f> &targets = _targetPositions.value();
    for(const Vec3f &target : targets) {
        if(!target.is_zero()) {
            return true;
        }
    }
    
    return false; // If all targets are zero, then the vertex is not animated.
}

Vec3f BuildModelVertex::animated_position(const std::vector<float> &weights) const {
    if(weights.size() == 0 || !_targetPositions.has_value()) {
        return position();
    }
    
    DebugHelper::assert_(weights.size() == _targetPositions.value().size(), 
        "(BuildModelVertex::animated_position) Number of weights does not match number of morph targets!");
        
    Vec3f out = position();
    
    const std::vector<Vec3f> &targets = _targetPositions.value();
    
    for(size_t i = 0; i < weights.size(); i++) {
        out += targets.at(i) * weights.at(i);
    }
    
    return out;
}
